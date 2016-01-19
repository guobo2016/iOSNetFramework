

//
//  NSArray+Additional.m
//  StudentStudy
//
//  Created by guobo on 15/6/13.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "NSArray+Additional.h"

@implementation NSArray (Additional)

-(id)getObjectAtIndex:(NSUInteger)index
{
    if (index<self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}
@end
