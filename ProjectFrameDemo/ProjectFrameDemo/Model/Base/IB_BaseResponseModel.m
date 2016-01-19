//
//  IBBaseModel.m
//  ProjectFrameDemo
//
//  Created by 郭波 on 15/12/15.
//  Copyright © 2015年 XX_Company. All rights reserved.
//

#import "IB_BaseResponseModel.h"

@implementation IB_BaseResponseModel

-(NSDictionary *)attrMapDict
{
    return @{@"message":@"Message",@"data":@"Data",@"code":@"Code"};
}

@end
