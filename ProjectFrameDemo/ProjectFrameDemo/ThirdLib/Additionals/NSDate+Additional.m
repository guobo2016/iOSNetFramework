//
//  NSDate+Additional.m
//  StudentStudyNew
//
//  Created by guobo on 15/7/3.
//  Copyright (c) 2015年 奥鹏教育. All rights reserved.
//

#import "NSDate+Additional.h"

@implementation NSDate (Additional)

- (NSString *)convertToStringWithFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:format];
    NSString *time = [dateFormatter stringFromDate:self];
    return time;
}
@end
