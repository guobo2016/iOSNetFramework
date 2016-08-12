

//
//  NSObject+Addtion.m
//  StudentStudyNew
//
//  Created by guobo on 15/8/7.
//  Copyright (c) 2015年 奥鹏教育. All rights reserved.
//

#import "NSObject+Addtion.h"
#import "AppDelegate.h"
@implementation NSObject (Addtion)

- (IBBaseViewController *)getCurrentVC:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[IBBaseViewController class]]) {
            break;
        }
    }
    return target;
}
@end
