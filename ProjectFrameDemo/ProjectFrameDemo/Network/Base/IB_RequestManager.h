//
//  IB_RequestManager.h
//  ProjectFrameDemo
//
//  Created by 郭波 on 16/1/19.
//  Copyright © 2016年 XX_Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IB_BaseRequest.h"
#import "IB_AppDotNetAPIClient.h"
#import "IB_FileManager.h"

/**
 *  请求管理类
 */
@interface IB_RequestManager : NSObject

+ (instancetype)sharedManager;

/**
 *  发送请求
 *
 *  @param requestUrl   请求url
 *  @param method       http方式
 *  @param paramsDict   参数字典
 *  @param successBlock 成功Block
 *  @param failBlock    失败Block
 */
- (void)sendRequest:(NSString*)requestUrl method:(kHttpMethod)method params:(NSDictionary*)paramsDict successBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))successBlock failBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failBlock;

@end
