


//
//  IB_DemoRequest.m
//  ProjectFrameDemo
//
//  Created by 郭波 on 16/1/19.
//  Copyright © 2016年 XX_Company. All rights reserved.
//

#import "IBDemoRequest.h"
#import "IBExampleModel.h"

@implementation IBDemoRequest

- (instancetype)init
{
    self = [super initRequestUrl:Example_URL method:kHttpMethodPost cacheType:kHttpCacheTypeLoadLocalCache encrypt:NO];
    if (self) {
        [self setValue:@"4218582" forKey:@"userId"];
        [self setPageNumber:1];
        [self setPageSize:200];
    }
    return self;
}

- (void)processResult:(IBBaseResponseModel*)baseModel
{
    NSMutableArray* resultArray = [NSMutableArray array];
    for (NSDictionary* dict in baseModel.data) {
        IBExampleModel* model = [IBExampleModel objectFromDictionary:dict];
        [resultArray addObject:model];
    }
    baseModel.data = resultArray;
}
@end
