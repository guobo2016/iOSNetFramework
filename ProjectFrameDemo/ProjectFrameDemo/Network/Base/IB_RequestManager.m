

//
//  IB_RequestManager.m
//  ProjectFrameDemo
//
//  Created by 郭波 on 16/1/19.
//  Copyright © 2016年 XX_Company. All rights reserved.
//

#import "IB_RequestManager.h"

@interface IB_RequestManager()
{
    typeof (void (^)(NSURLSessionDataTask *task, id responseObject)) _successBlock;
    typeof (void (^)(NSURLSessionDataTask *task, NSError *error)) _failBlock;
}
@property (strong,nonatomic,readonly)     NSURLSessionDataTask* currentTask;

@end

@implementation IB_RequestManager

+ (void)sendRequest:(NSString*)requestUrl method:(kHttpMethod)method params:(NSDictionary*)paramsDict successBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))successBlock failBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failBlock
{
    NSURLSessionDataTask* currentTask = nil;
    switch (method) {
        case kHttpMethodPost:
        {
            currentTask = [[IB_AppDotNetAPIClient sharedClient]POST:requestUrl parameters:paramsDict success:^(NSURLSessionDataTask *task, id responseObject) {
                successBlock(task,responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                failBlock(task,error);
            }];
        }
            break;
        case kHttpMethodGet:
        {
            currentTask = [[IB_AppDotNetAPIClient sharedClient]GET:requestUrl parameters:paramsDict success:^(NSURLSessionDataTask *task, id responseObject) {
                successBlock(task,responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                failBlock(task,error);
            }];
        }
            break;
        default:
            break;
    }
}

@end
