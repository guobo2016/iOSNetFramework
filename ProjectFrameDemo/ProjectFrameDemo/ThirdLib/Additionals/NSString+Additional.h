//
//  NSString+LSAdditional.h
//  
//
//  Created by Bob on 14-5-5.
//  Copyright (c) 2014年 LASHOU-INC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additional)



/**
 * Determines if the string contains only whitespace.
 */
- (BOOL)isWhitespace;

/**
 * Determines if the string is empty or contains only whitespace.
 */
- (BOOL)isEmptyOrWhitespace;

/**
 * Checks to see if the string contains the given string, case insenstive
 */
- (BOOL)containsString:(NSString*)string;

/**
 * Checks to see if the string contains the given string while allowing you to define the compare options
 */
- (BOOL)containsString:(NSString*)string options:(NSStringCompareOptions)options;
+ (int)getRandomNumber:(int)from to:(int)to;
/**
 * Returns the MD5 value of the string
 */
- (NSString*)md5;


- (NSString*)encodeAsURIComponent;

- (NSString *)encodingURL;
- (NSString *)decodeingURL:(NSString *)str;

/// Get a string where internal characters that need escaping for HTML are escaped
//
///  For example, '&' become '&amp;'. This will only cover characters from table
///  A.2.2 of http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
///  which is what you want for a unicode encoded webpage. If you have a ascii
///  or non-encoded webpage, please use stringByEscapingAsciiHTML which will
///  encode all characters.
///
/// For obvious reasons this call is only safe once.
//
//  Returns:
//    Autoreleased NSString
//

- (CGFloat)widthWithFont:(UIFont *)font;

// 支付密码加密
+ (NSString *)encryptPassworToString:(NSString *)password;
// 支付密码解密
+ (NSString *)decrytPasswordFromString:(NSString *)str;


//隐藏部分电话号码
- (NSString *)hideTelephoneNumber;
//隐藏部分用户名
- (NSString *)hideUserName;

//把NSString,NSArray,NSDictionary转换为标准JSON字符串
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithObject:(id) object;
+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithArray:(NSArray *)array;


/**
 *@brief 根据当前的字符串字体获取字符串的CGSize数据，自动适配IOS7和IOS7以下系统
 *@param font   当前字符串的字体
 */
- (CGSize)getSizeWithFont:(UIFont *)font;

/**
 *@brief 实现NSString画文字功能，自动适配IOS7和IOS7以下系统
 *
 */
- (CGSize)adaptDrawInRect:(CGRect)rect
                 withFont:(UIFont *)font
                withColor:(UIColor*)color;

- (CGSize)adaptDrawInRect:(CGRect)rect
                 withFont:(UIFont *)font
                withColor:(UIColor*)color
            lineBreakMode:(kLineBreadMode)lineBreakMode;

- (CGSize)adaptDrawInRect:(CGRect)rect
                 withFont:(UIFont *)font
                withColor:(UIColor*)color
            lineBreakMode:(kLineBreadMode)lineBreakMode
                alignment:(kTextAlignment)alignment;

- (void)adaptDrawPoint:(CGPoint)point withFont:(UIFont*)font;
- (CGSize)adaptSizeWithFont:(UIFont*)font withWidth:(CGFloat)width mode:(kLineBreadMode)lineBreakMode;
- (CGSize)adaptSizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(kLineBreadMode)lineMode;
- (NSString *)removeWhiteSpace;
/**
 *  去除html标签
 *
 *
 *  @return 无html标签的文本
 */
-(NSString *)filterHTML;

/**
 *  字符串异或加密
 *
 *  @param key 加密key
 *
 *  @return
 */
- (NSString *)obfuscateWithKey:(NSString *)key;

@end
