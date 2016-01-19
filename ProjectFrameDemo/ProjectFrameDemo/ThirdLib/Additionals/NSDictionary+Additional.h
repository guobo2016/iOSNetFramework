//
//  NSDictionary+Additional.h
//  
//
//  Created by Bob on 14-5-16.
//  Copyright (c) 2014年 Bob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additional)
/**
 *  获取bool类型的值,默认值NO
 *
 *  @param key
 *
 *  @return value
 */
- (BOOL)getBoolValueForKey:(NSString *)key;
- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
/**
 *  获取Int类型的值,默认值 0
 *
 *  @param key key description
 *
 *  @return return value description
 */
- (int)getIntValueForKey:(NSString *)key;
- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue;
/**
 *  获取time_t类型的值,默认值 0
 *
 *  @param key key description
 *
 *  @return return value description
 */
- (time_t)getTimeValueForKey:(NSString *)key;
- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue;
/**
 *  获取long long类型的值,默认值 0
 *
 *  @param key key description
 *
 *  @return return value description
 */
- (long long)getLongLongValueValueForKey:(NSString *)key;
- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue;
/**
 *  获取String类型的值,默认值 @""
 *
 *  @param key key description
 *
 *  @return return value description
 */
- (NSString *)getStringValueForKey:(NSString *)key;
- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
/**
 *  获取Object类型的值,默认值 nil
 *
 *  @param key key description
 *
 *  @return return value description
 */
- (id)getObjectForKey:(NSString*)key;
- (id)getObjectForKey:(NSString*)key defaultValue:(id)defaultValue;


/*
 获取以字符串形式存放的Int类型值,用于简化调用时的判断处理
 */
- (int)getStringIntValueForKey:(NSString *)key defaultValue:(int)defaultValue;
@end
