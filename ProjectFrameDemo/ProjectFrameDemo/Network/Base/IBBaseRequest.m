

//
//  IB_BaseRequest.m
//  ProjectFrameDemo
//
//  Created by 郭波 on 16/1/19.
//  Copyright © 2016年 XX_Company. All rights reserved.
//

#import "IBBaseRequest.h"
#import "IBAppDotNetAPIClient.h"
#import "AFHTTPRequestOperation.h"
#import <CommonCrypto/CommonDigest.h>
#import "IBError.h"
#import "NSString+IBEncrypt.h"
#import "IBCacheManager.h"
#import "IBRequestManager.h"
#import <objc/objc.h>
#import <objc/runtime.h>

#define IB_BASEREQUEST_METHODNAME_KEY @"IB_BASEREQUEST_METHODNAME_KEY"


@interface IBBaseRequest()
{
    void(^_requestSuccFinishBlock)(id result);
    void(^_requestFailFinishBlock)(IBError* error);
    void(^_finalBlock)();
    NSDictionary*   _responseDict;
    NSDictionary*   _cacheResponseDict;
}
@property (strong,nonatomic)     NSString* requestUrl;
@property (assign,nonatomic)     kHttpMethod requestMethod;
@property (assign,nonatomic)     kHttpCacheType requestCacheType;
@property (strong,nonatomic)     NSMutableDictionary* parametersDic;
@property (assign,nonatomic)     BOOL encrypt;
@property (assign,nonatomic)     NSInteger pageNumber;
@property (assign,nonatomic)     NSInteger pageSize;

@end
@implementation IBBaseRequest

- (void)dealloc
{
    _finalBlock = nil;
    _requestFailFinishBlock = nil;
    _requestSuccFinishBlock = nil;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"网络请求初始化失败" reason:@"不允许调用IB_BaseRequest的init方式进行初始化，请使用带参数的初始化方法" userInfo:nil];
    return nil;
}

- (instancetype)initRequestUrl:(NSString*)url
{
    return [self initRequestUrl:url method:kHttpMethodPost];
}

- (instancetype)initRequestUrl:(NSString*)url method:(kHttpMethod)method
{
    return [self initRequestUrl:url method:method cacheType:kHttpCacheTypeIgnoreCache];
}

- (instancetype)initRequestUrl:(NSString*)url method:(kHttpMethod)method cacheType:(kHttpCacheType)cacheType
{
    return [self initRequestUrl:url method:method cacheType:cacheType encrypt:NO];
}

- (instancetype)initRequestUrl:(NSString*)url method:(kHttpMethod)method cacheType:(kHttpCacheType)cacheType encrypt:(BOOL)encrypt
{
    self = [super init];
    if (self) {
        _parametersDic = [NSMutableDictionary dictionary];
        _requestUrl = url;
        _requestMethod = method;
        _requestCacheType = cacheType;
        _encrypt = encrypt;
    }
    return self;
}

#pragma mark public method

- (void)sendRequestSuccessBlock:(void(^)(IBBaseResponseModel* baseModel))requestSuccessBlock requestFailBlock:(void(^)(IBError* error))requestFailBlock finalBlock:(void(^)())finalBlock
{
    [self popNullExceptionIfNeed];
    _requestSuccFinishBlock = requestSuccessBlock;
    _requestFailFinishBlock = requestFailBlock;
    _finalBlock = finalBlock;

    if (self.pageSize > 0) {//分页情况的处理
        _parametersDic[Request_PAGE_NUMBER] = [NSString stringWithFormat:@"%zd",self.pageNumber];
        _parametersDic[Request_PAGE_SIZE] = [NSString stringWithFormat:@"%zd",self.pageSize];
    }
    if (self.requestCacheType == kHttpCacheTypeLoadLocalCache) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary* cacheDict = [IBCacheManager readCacheDiskByUrl:self.requestUrl params:_parametersDic];
            if(cacheDict){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self handleResponse:cacheDict isReadCache:YES];
                });
            }
        });
    }
    objc_setAssociatedObject([self class], IB_BASEREQUEST_METHODNAME_KEY, self.requestUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sendRequest];
}

+ (void)cancel
{
    NSString* url = objc_getAssociatedObject([self class], IB_BASEREQUEST_METHODNAME_KEY);

    for (NSURLSessionDataTask* task in [IBAppDotNetAPIClient sharedClient].tasks) {
        NSString* origionUrl = task.currentRequest.URL.absoluteString;
        if ([origionUrl rangeOfString:url].location!=NSNotFound) {
            [task cancel];
        }
    }
}

- (void)processResult:(IBBaseResponseModel *)baseModel
{
    
}

- (void)setIntegerValue:(NSInteger)value forKey:(NSString *)key
{
    [self setValue:[NSString stringWithFormat:@"%zd", value] forKey:key];
}

- (void)setDoubleValue:(double)value forKey:(NSString *)key
{
    [self setValue:[NSString stringWithFormat:@"%f", value] forKey:key];
}

- (void)setLongLongValue:(long long)value forKey:(NSString *)key
{
    [self setValue:[NSString stringWithFormat:@"%lld", value] forKey:key];
}

- (void)setBOOLValue:(BOOL)value forKey:(NSString *)key
{
    [self setValue:[NSString stringWithFormat:@"%d", value] forKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if(!value){
        value = @"";
    }
    [_parametersDic setValue:value forKey:key];
}

#pragma mark private method

/**
 *  发起请求
 */
- (void)sendRequest
{
    [IBRequestManager sendRequest:self.requestUrl method:self.requestMethod params:self.parametersDic successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleResponse:responseObject isReadCache:NO];
        dispatch_barrier_sync(dispatch_get_global_queue(0, 0), ^{
            [IBCacheManager writeCacheDisk:responseObject url:self.requestUrl params:_parametersDic];
        });
    } failBlock:^(NSURLSessionDataTask *task, NSError *error) {
        IBError* bError = [[IBError alloc]initWithDomain:error.domain code:error.code userInfo:error.userInfo];
        if (_requestFailFinishBlock) {
            _requestFailFinishBlock(bError);
        }
        if (_finalBlock) {
            _finalBlock();
        }
        _requestFailFinishBlock = nil;
        _requestSuccFinishBlock = nil;
        _finalBlock = nil;
    }];
}
/**
 *  数据解析
 *
 *  @param responseObject 结果字典
 *  @param isReadCache    是否读取的缓存数据
 */
-(void)handleResponse:(id)responseObject isReadCache:(BOOL)isReadCache
{
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        if (isReadCache) {
            _cacheResponseDict = responseObject;
        }else{
            _responseDict = responseObject;
        }
        if (self.requestCacheType == kHttpCacheTypeLoadLocalCache) {
            if (!isReadCache && [self checkEqualDict:_cacheResponseDict withDestDict:_responseDict]) {
                _requestSuccFinishBlock = nil;
                _requestFailFinishBlock = nil;
                _finalBlock = nil;
                return;
            }
        }
        IBBaseResponseModel* baseModel = [IBBaseResponseModel objectFromDictionary:responseObject];
        if (baseModel.code == kErrorCode_Success) {
            [self processResult:baseModel];
        }
        baseModel.isCache = isReadCache;
        IBError* bError = nil;
        if (_requestSuccFinishBlock && baseModel.code == kErrorCode_Success) {
            _requestSuccFinishBlock(baseModel);
        }else if(_requestFailFinishBlock && baseModel.code != kErrorCode_Success){
            bError = [[IBError alloc]initWithDomain:self.requestUrl code:baseModel.code userInfo:@{@"description":baseModel.message}];
            _requestFailFinishBlock(bError);
        }
        if (_finalBlock) {
            _finalBlock();
        }
        if (!isReadCache) {
            _requestSuccFinishBlock = nil;
            _requestFailFinishBlock = nil;
            _finalBlock = nil;
        }
    }else{
        IBError* error = [[IBError alloc]initWithDomain:self.requestUrl code:kErrorCode_Data_Error userInfo:@{@"description":@"数据解析失败"}];
        if (_requestFailFinishBlock) {
            _requestFailFinishBlock(error);
        }
        if (_finalBlock) {
            _finalBlock();
        }
        if (!isReadCache) {
            _requestSuccFinishBlock = nil;
            _requestFailFinishBlock = nil;
            _finalBlock = nil;
        }
    }
}

/**
 *  抛出空异常
 */
- (void)popNullExceptionIfNeed
{
    if (!self.requestUrl) {
        @throw [NSException exceptionWithName:@"网络请求参数错误" reason:@"没有重写父类的setRequestUrl方法" userInfo:nil];
    }
}

/**
 *  判断两个字典是否相等
 *
 *  @param sourceDict 源字典
 *  @param destDict   目标字典
 *
 *  @return 是否相等
 */
- (BOOL)checkEqualDict:(NSDictionary*)sourceDict withDestDict:(NSDictionary*)destDict
{
    if (_responseDict && _cacheResponseDict  && [_cacheResponseDict isEqualToDictionary:_responseDict]) {//如果网络请求返回的数据与缓存数据完成一致，则不需要再次刷新界面
        return YES;
    }
    return NO;
}
@end
