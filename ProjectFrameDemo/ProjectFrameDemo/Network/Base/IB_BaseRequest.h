//
//  IB_BaseRequest.h
//  ProjectFrameDemo
//
//  Created by 郭波 on 16/1/19.
//  Copyright © 2016年 XX_Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IB_Error.h"
#import "IB_BaseResponseModel.h"

#define Request_PAGE_NUMBER @"pageNumber"
#define Request_PAGE_SIZE @"pageSize"

typedef NS_ENUM(NSInteger,kHttpMethod) {
    /**
     *  POST请求方式
     */
    kHttpMethodPost = 0,
    /**
     *  Get请求方式
     */
    kHttpMethodGet = 1
};
typedef NS_ENUM(NSInteger,kHttpCacheType) {
    /**
     *  不需要缓存
     */
    kHttpCacheTypeIgnoreCache = 0,
    /**
     *  先读取本地缓存,再取网络数据
     */
    kHttpCacheTypeLoadLocalCache = 1,
    /**
     *  若服务器返回code = 9999，读取本地缓存（暂未开发）
     */
    kHttpCacheTypeLoadServerCache = 2
};
@interface IB_BaseRequest : NSObject
/**
 *  初始化网络请求
 *
 *  @param url       请求url
 *  @return          实例
 */
- (instancetype)initRequestUrl:(NSString*)url;
/**
 *  初始化网络请求
 *
 *  @param url       请求url
 *  @param method    请求方式
 *  @return          实例
 */
- (instancetype)initRequestUrl:(NSString*)url method:(kHttpMethod)method;

/**
 *  初始化网络请求
 *
 *  @param url       请求url
 *  @param method    请求方式
 *  @param cacheType 缓存方式
 *  @return          实例
 */
- (instancetype)initRequestUrl:(NSString*)url method:(kHttpMethod)method cacheType:(kHttpCacheType)cacheType;
/**
 *  初始化网络请求
 *
 *  @param url       请求url
 *  @param method    请求方式
 *  @param cacheType 缓存方式
 *  @param encrypt   是否加密
 *  @return          实例
 */
- (instancetype)initRequestUrl:(NSString*)url method:(kHttpMethod)method cacheType:(kHttpCacheType)cacheType encrypt:(BOOL)encrypt;
///**
// *  设置网络请求url
// *
// *  @param url
// */
//- (void)setRequestUrl:(NSString*)requestUrl;
///**
// *  设置http方式
// *
// *  @param method
// */
//- (void)setRequestMethod:(kHttpMethod)requestMethod;
///**
// *  设置缓存方式
// *
// *  @param type
// */
//- (void)setRequestCacheType:(kHttpCacheType)cacheType;
///**
// *  设置是否需要加密
// *
// *  @param encrypt 
// */
//- (void)setEncrypt:(BOOL)encrypt;
///**
// *  设置pageNumber
// *
// *  @param pageNumber pageNumber description
// */
- (void)setPageNumber:(NSInteger)pageNumber;
/**
 *  设置pageSize
 *
 *  @param pageSize pageSize description
 */
- (void)setPageSize:(NSInteger)pageSize;
/**
 *  解析返回的数据结果
 *  子类可以重写此方式来进行数据解析
 *  @param resultDict 处理过data节点中数据的model
 *
 */
- (void)processResult:(IB_BaseResponseModel*)baseModel;
/**
 *  设置整型值
 *
 *  @param value value description
 *  @param key   key description
 */
- (void)setIntegerValue:(NSInteger)value forKey:(NSString *)key;
/**
 *  设置Double值
 *
 *  @param value value description
 *  @param key   key description
 */
- (void)setDoubleValue:(double)value forKey:(NSString *)key;
/**
 *  设置LONGLONG值
 *
 *  @param value value description
 *  @param key   key description
 */
- (void)setLongLongValue:(long long)value forKey:(NSString *)key;
/**
 *  设置BOOL值
 *
 *  @param value value description
 *  @param key   key description
 */
- (void)setBOOLValue:(BOOL)value forKey:(NSString *)key;
/**
 *  设置值
 *
 *  @param value value description
 *  @param key   key description
 */
- (void)setValue:(id)value forKey:(NSString *)key;
/**
 *  发送请求
 *
 *  @param requestSuccessBlock 成功Block
 *  @param requestFailBlock    失败Block
 *  @param finalBlock          成功或者失败都执行的Block
 */
- (void)sendRequestSuccessBlock:(void(^)(IB_BaseResponseModel* baseModel))requestSuccessBlock requestFailBlock:(void(^)(IB_Error* error))requestFailBlock finalBlock:(void(^)())finalBlock;
/**
 *  关闭网络请求
 *
 */
+(void)cancel;

@end
