//
//  NSMutableArray+LSAdditional.m
//  
//
//  Created by Bob on 14-5-16.
//  Copyright (c) 2014年 Bob. All rights reserved.
//

#import "NSMutableArray+Additional.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Additional)

- (void)setTotalGoodsCount:(NSInteger)totalGoodsCount {
    objc_setAssociatedObject(self, @"kTotalGoodsCount", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @"kTotalGoodsCount", [NSNumber numberWithInteger:totalGoodsCount], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)totalGoodsCount {
    NSNumber *count = objc_getAssociatedObject(self, @"kTotalGoodsCount");
    if(count) {
        return [count integerValue];
    } else {
        return 0;
    }
}

- (void)setRecordsOffset:(NSInteger)recordsOffset {
    objc_setAssociatedObject(self, @"kRecordsOffset", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @"kRecordsOffset", [NSNumber numberWithInteger:recordsOffset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)recordsOffset {
    NSNumber *offset = objc_getAssociatedObject(self, @"kRecordsOffset");
    if(offset) {
        return [offset integerValue];
    } else {
        return 0;
    }
}

@end
