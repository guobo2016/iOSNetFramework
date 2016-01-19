


//
//  IB_DemoRequest.m
//  ProjectFrameDemo
//
//  Created by 郭波 on 16/1/19.
//  Copyright © 2016年 XX_Company. All rights reserved.
//

#import "IB_DemoRequest.h"
#import "IB_ExampleModel.h"

@implementation IB_DemoRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setRequestUrl:Example_URL];
        [self setRequestMethod:kHttpMethodPost];
        [self setRequestCacheType:kHttpCacheTypeLoadLocalCache];
        [self setValue:@"4218582" forKey:@"userId"];
        [self setPageNumber:1];
        [self setPageSize:200];
    }
    return self;
}

- (void)processResult:(IB_BaseResponseModel*)baseModel
{
    NSMutableArray* resultArray = [NSMutableArray array];
    for (NSDictionary* dict in baseModel.data) {
        IB_ExampleModel* model = [IB_ExampleModel objectFromDictionary:dict];
        [resultArray addObject:model];
    }
    baseModel.data = resultArray;
}
@end
