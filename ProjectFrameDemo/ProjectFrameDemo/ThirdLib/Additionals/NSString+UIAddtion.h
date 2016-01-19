//
//  NSString+UIAddtion.h
//  StudentStudyNew
//
//  Created by guobo on 15/8/6.
//  Copyright (c) 2015年 奥鹏教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UIAddtion)

-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing;

@end
