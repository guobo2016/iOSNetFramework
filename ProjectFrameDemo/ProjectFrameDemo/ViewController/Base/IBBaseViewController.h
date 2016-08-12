//
//  BaseViewController.h
//  _6.0
//
//  Created by Bob on 13-10-21.
//  Copyright (c) 2013年 Bob. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIViewController+NavigationBar.h"
/**
 *  UIViewController基类
 */
@interface IBBaseViewController : UIViewController<UIGestureRecognizerDelegate>
/**
 *  显示loading框
 *
 *  @param title 描述文字
 */
- (void)showProgressViewWithTitle:(NSString *)title;
/**
 *  隐藏loading框
 */
- (void)hideProgressView;

@end
