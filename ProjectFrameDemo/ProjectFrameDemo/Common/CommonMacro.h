//
//  CommonMacro.h
//  ProjectFrameDemo
//
//  Created by 郭波 on 15/12/14.
//  Copyright © 2015年 XX_Company. All rights reserved.
//
#ifndef CommonMacro_h
#define CommonMacro_h

#ifdef __IPHONE_6_0

#define kTextAlignment                      NSTextAlignment
#define kTextAlignmentLeft                  NSTextAlignmentLeft
#define kTextAlignmentCenter                NSTextAlignmentCenter
#define kTextAlignmentRight                 NSTextAlignmentRight

#define kLineBreadMode                      NSLineBreakMode
#define kLineBreakModeCharaterWrap          NSLineBreakByCharWrapping
#define kLineBreakModeWordWrap              NSLineBreakByWordWrapping
#define kLineBreakModeClip                  NSLineBreakByClipping
#define kLineBreakModeTruncatingHead        NSLineBreakByTruncatingHead
#define kLineBreakModeTruncatingMiddle      NSLineBreakByTruncatingMiddle
#define kLineBreakModeTruncatingTail        NSLineBreakByTruncatingTail

#else

#define kTextAlignment                      UITextAlignment
#define kTextAlignmentLeft                  UITextAlignmentLeft
#define kTextAlignmentCenter                UITextAlignmentCenter
#define kTextAlignmentRight                 UITextAlignmentRight

#define kLineBreadMode                      UILineBreakMode
#define kLineBreakModeCharaterWrap          UILineBreakModeCharacterWrap
#define kLineBreakModeWordWrap              UILineBreakModeWordWrap
#define kLineBreakModeClip                  UILineBreakModeClip
#define kLineBreakModeTruncatingHead        UILineBreakModeHeadTruncation
#define kLineBreakModeTruncatingMiddle      UILineBreakModeMiddleTruncation
#define kLineBreakModeTruncatingTail        UILineBreakModeTailTruncation

#endif


#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif
/*
 *@bref  系统版本判断
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define iOS7System (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES:NO)
#define iOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define CURRENTSYSTEM  [[[UIDevice currentDevice] systemVersion] floatValue]

#define RGBA(r,g,b,a)               [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
#define RGB(r,g,b)                  [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1.0f]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define FONT(f)                     [UIFont systemFontOfSize:f]


#define kSoftwareVersion    ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]) //获取app的版本号
#define kMainBoundsHeight   ([UIScreen mainScreen].bounds).size.height //屏幕的高度
#define kMainBoundsWidth    ([UIScreen mainScreen].bounds).size.width //屏幕的宽度


#endif
