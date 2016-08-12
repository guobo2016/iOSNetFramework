//
//  NSString+IB_Encrypt.h
//  ProjectFrameDemo
//
//  Created by 郭波 on 16/1/19.
//  Copyright © 2016年 XX_Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IBEncrypt)
/**
 *  md5加密
 *
 *  @return 
 */
- (NSString*)md5;
/**
 *  des加密
 *
 */
- (NSString *)encrypt;
/**
 *  des解密
 *
 */
- (NSString *)decrypt;
@end
