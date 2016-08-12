

//
//  IBError.m
//  ProjectFrameDemo
//
//  Created by 郭波 on 15/12/15.
//  Copyright © 2015年 XX_Company. All rights reserved.
//

#import "IBError.h"

@implementation IBError

-(instancetype)initWithDomain:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *)dict
{
    NSInteger errorCode = code;
    NSString* errorDesc = dict[@"NSLocalizedDescription"];
    if (code == -999) {
        errorCode = kErrorCode_Cancel;
        errorDesc = @"请求关闭";
    }else if(code == -1009){
        errorCode = kErrorCode_Internet_Error;
        errorDesc = @"网络异常";
    }else if(code == NSURLErrorTimedOut){
        errorCode = kErrorCode_TimeOut_Error;
        errorDesc = @"网络连接超时";
    }
    if (!dict[@"description"]) {
        dict = @{@"description":errorDesc};
    }
    self = [super initWithDomain:domain code:errorCode userInfo:dict];
    return self;
}
@end
