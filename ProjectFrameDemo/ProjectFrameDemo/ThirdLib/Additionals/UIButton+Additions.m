

//
//  UIButton+Additions.m
//  StudentStudyNew
//
//  Created by guobo on 15/5/28.
//  Copyright (c) 2015年 奥鹏教育. All rights reserved.
//

#import "UIButton+Additions.h"

@implementation UIButton (Additions)

-(void)setBorderColor:(UIColor*)color cornerRadius:(CGFloat)radius
{
    if(color){
        self.layer.borderColor = color.CGColor;
        self.layer.borderWidth = 0.5f;
    }
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}
@end
