//
//  IB_FileManager.h
//  ProjectFrameDemo
//
//  Created by 郭波 on 16/1/19.
//  Copyright © 2016年 XX_Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IB_CacheManager : NSObject

/**
 *  读取网络缓存
 *
 *  @param url           网络url
 *  @param parametersDic 参数字典
 *
 *  @return 缓存数据
 */
+ (NSDictionary*)readCacheDiskByUrl:(NSString*)url params:(NSDictionary*)parametersDic;
/**
 *  生成url+参数字符串
 *
 *  @param url           url
 *  @param parametersDic 参数字典
 *
 *  @return url+参数字符串
 */
+ (NSMutableString *)getUrlMulStringByUrl:(NSString*)url params:(NSDictionary*)parametersDic;
/**
 *  写入缓存
 *
 *  @param resultDict    结果字典
 *  @param url           url
 *  @param parametersDic 参数字典
 */
+ (void)writeCacheDisk:(NSMutableDictionary*)resultDict url:(NSString*)url params:(NSDictionary*)parametersDic;


@end
