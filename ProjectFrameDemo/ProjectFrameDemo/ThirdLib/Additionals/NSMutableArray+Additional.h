//
//  NSMutableArray+LSAdditional.h
//  
//
//  Created by Bob on 14-5-16.
//  Copyright (c) 2014年 Bob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Additional)

@property (nonatomic, assign) NSInteger totalGoodsCount;    //列表数组总数
@property (nonatomic, assign) NSInteger recordsOffset;      //列表偏移量，即数组的当前位置

@end
