

//
//  UIViewController+Addtion.m
//  StudentStudyNew
//
//  Created by guobo on 15/8/18.
//  Copyright (c) 2015年 奥鹏教育. All rights reserved.
//

#import "UIViewController+Addtion.h"
//#import "UMSAgent.h"

@implementation UIViewController (Addtion)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

-(void)viewWillAppear:(BOOL)animated
{
    if ([self isKindOfClass:[UINavigationController class]] || [self isKindOfClass:[UITabBarController class]]) {
        return;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    if ([self isKindOfClass:[UINavigationController class]] || [self isKindOfClass:[UITabBarController class]]) {
        return;
    }
}

#pragma clang diagnostic pop

@end
