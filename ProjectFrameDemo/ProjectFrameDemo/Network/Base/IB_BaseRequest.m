

//
//  IB_BaseRequest.m
//  ProjectFrameDemo
//
//  Created by 郭波 on 16/1/19.
//  Copyright © 2016年 XX_Company. All rights reserved.
//

#import "IB_BaseRequest.h"
#import "IB_AppDotNetAPIClient.h"
#import "AFHTTPRequestOperation.h"
#import <CommonCrypto/CommonDigest.h>
#import "IB_Error.h"
#import "NSString+IB_Encrypt.h"
#import "IB_CacheManager.h"
#import "IB_RequestManager.h"
#import <objc/objc.h>
#import <objc/runtime.h>

#define IB_BASEREQUEST_METHODNAME_KEY @"IB_BASEREQUEST_METHODNAME_KEY"


@interface IB_BaseRequest()
{
    void(^_requestSuccFinishBlock)(id result);
    void(^_requestFailFinishBlock)(IB_Error* error);
    void(^_finalBlock)(id result,IB_Error* error);
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
@implementation IB_BaseRequest

- (void)dealloc
{
    _finalBlock = nil;
    _requestFailFinishBlock = nil;
    _requestSuccFinishBlock = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _parametersDic = [NSMutableDictionary dictionary];
    }
    return self;
}
#pragma mark public method

- (void)sendRequestSuccessBlock:(void(^)(IB_BaseResponseModel* baseModel))requestSuccessBlock requestFailBlock:(void(^)(IB_Error* error))requestFailBlock finalBlock:(void(^)(IB_BaseResponseModel* baseModel,IB_Error* error))finalBlock
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
            NSDictionary* cacheDict = [IB_CacheManager readCacheDiskByUrl:self.requestUrl params:_parametersDic];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self handleResponse:cacheDict isReadCache:YES];
            });
        });
    }
    objc_setAssociatedObject([self class], IB_BASEREQUEST_METHODNAME_KEY, self.requestUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sendRequest];
}

+ (void)cancel
{
    NSString* url = objc_getAssociatedObject([self class], IB_BASEREQUEST_METHODNAME_KEY);

    for (NSURLSessionDataTask* task in [IB_AppDotNetAPIClient sharedClient].tasks) {
        NSString* origionUrl = task.currentRequest.URL.absoluteString;
        if ([origionUrl rangeOfString:url].location!=NSNotFound) {
            [task cancel];
        }
    }
}

- (void)processResult:(IB_BaseResponseModel *)baseModel
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
    [IB_RequestManager sendRequest:self.requestUrl method:self.requestMethod params:self.parametersDic successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleResponse:responseObject isReadCache:NO];
        dispatch_barrier_sync(dispatch_get_global_queue(0, 0), ^{
            [IB_CacheManager writeCacheDisk:responseObject url:self.requestUrl params:_parametersDic];
        });
    } failBlock:^(NSURLSessionDataTask *task, NSError *error) {
        IB_Error* bError = [[IB_Error alloc]initWithDomain:error.domain code:error.code userInfo:error.userInfo];
        if (_requestFailFinishBlock) {
            _requestFailFinishBlock(bError);
        }
        if (_finalBlock) {
            _finalBlock(nil,bError);
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
            if (_responseDict && _cacheResponseDict && !isReadCache && [_cacheResponseDict isEqualToDictionary:_responseDict]) {//如果网络请求返回的数据与缓存数据完成一直，则不需要再次刷新界面
                _requestSuccFinishBlock = nil;
                _requestFailFinishBlock = nil;
                _finalBlock = nil;
                return;
            }
        }
        
        IB_BaseResponseModel* baseModel = [IB_BaseResponseModel objectFromDictionary:responseObject];
        if (baseModel.code == kErrorCode_Success) {
            [self processResult:baseModel];
        }
        baseModel.isCache = isReadCache;
        IB_Error* bError = nil;
        if (_requestSuccFinishBlock && baseModel.code == kErrorCode_Success) {
            _requestSuccFinishBlock(baseModel);
        }else if(_requestFailFinishBlock && baseModel.code != kErrorCode_Success){
            bError = [[IB_Error alloc]initWithDomain:self.requestUrl code:baseModel.code userInfo:@{@"description":baseModel.message}];
            _requestFailFinishBlock(bError);
        }
        if (_finalBlock) {
            _finalBlock(baseModel,bError);
        }
        if (!isReadCache) {
            _requestSuccFinishBlock = nil;
            _requestFailFinishBlock = nil;
            _finalBlock = nil;
        }
    }else{
        IB_Error* error = [[IB_Error alloc]initWithDomain:self.requestUrl code:kErrorCode_Data_Error userInfo:@{@"description":@"数据解析失败"}];
        if (_requestFailFinishBlock) {
            _requestFailFinishBlock(error);
        }
        if (_finalBlock) {
            _finalBlock(responseObject,error);
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

@end
