//
//  IBBaseViewController+NavigationBar.m
//  ProjectFrameDemo
//
//  Created by 郭波 on 15/12/17.
//  Copyright © 2015年 XX_Company. All rights reserved.
//

#import "UIViewController+NavigationBar.h"

@implementation UIViewController (NavigationBar)

/**
 *	@brief	自定义titlte居中处理
 *
 *	@param 	text 	title
 */
- (void)setNavTitle:(NSString *)title
{
    //注意必须先定义 leftBarButtonItem和rightBarButtonItem的位置
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 44)];
    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    titleView.autoresizesSubviews = YES;
    titleView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    titleLabel.autoresizingMask = titleView.autoresizingMask;
    //标题宽度
    CGFloat width = [title sizeWithFont:[UIFont systemFontOfSize:18]].width;
    CGFloat maxWidth = 120;
    if(width <= kMainBoundsWidth-2*maxWidth){
        titleLabel.frame = CGRectMake(0, 0, kMainBoundsWidth-maxWidth*2, 44);
        titleView.frame = CGRectMake(maxWidth, 0, kMainBoundsWidth-maxWidth*2, 44);
    }
    else{
        CGRect leftViewbounds = self.navigationItem.leftBarButtonItem.customView.bounds;
        CGRect rightViewbounds = self.navigationItem.rightBarButtonItem.customView.bounds;
        CGRect frame;
        CGFloat maxWidth = leftViewbounds.size.width > rightViewbounds.size.width ? leftViewbounds.size.width : rightViewbounds.size.width;
        maxWidth += 15;//leftview 左右都有间隙，左边是5像素，右边是8像素，加2个像素的阀值 5 ＋ 8 ＋ 2
        frame = titleLabel.frame;
        frame.size.width = kMainBoundsWidth - maxWidth * 2;
        titleLabel.frame = frame;
        
        frame = titleView.frame;
        frame.size.width = kMainBoundsWidth - maxWidth * 2;
        titleView.frame = frame;
    }
    titleLabel.text = title;
    [titleView addSubview:titleLabel];
    self.navigationItem.titleView = titleView;
}

- (void)setNavRightButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action
{
    self.navigationItem.rightBarButtonItem = [self getButtonItemWithImg:normalImg selImg:selImg title:title action:action isBorder:NO];
}

- (void)setNavLeftButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action
{
    self.navigationItem.leftBarButtonItem = [self getButtonItemWithImg:normalImg selImg:selImg title:title action:action isBorder:NO];
}

- (void)setNavLeftButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action isBorder:(BOOL)isBorder
{
    self.navigationItem.leftBarButtonItem = [self getButtonItemWithImg:normalImg selImg:selImg title:title action:action isBorder:isBorder];
}
-(void)setNavRightButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action isBorder:(BOOL)isBorder
{
    self.navigationItem.rightBarButtonItem = [self getButtonItemWithImg:normalImg selImg:selImg title:title action:action isBorder:isBorder];
}

- (void)setNavBackArrow{
    [self setNavBackArrowWithWidth:40];
}
- (void)setNavBackArrowWithWidth:(CGFloat)width
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    [button setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 50, width);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [button addTarget:self action:@selector(navBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)setNavRightButtonEnable:(BOOL)enable
{
    [self.navigationItem.rightBarButtonItem setEnabled:enable];
}

- (void)setNavLeftButtonEnable:(BOOL)enable
{
    [self.navigationItem.leftBarButtonItem setEnabled:enable];
}

#pragma mark - NavButton Clicked
- (void)navGoHomeButtonClicked:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)navBackButtonClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MG_NavBaseViewController private
- (UIBarButtonItem *)getButtonItemWithImg:(NSString *)norImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action isBorder:(BOOL)isBorder
{
    CGSize navbarSize = self.navigationController.navigationBar.bounds.size;
    CGRect frame = CGRectMake(0, 0, navbarSize.height, navbarSize.height - 3);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    if (norImg){
        UIImage* norImage = [UIImage imageNamed:norImg];
        [button setImage:norImage forState:UIControlStateNormal];
        button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, norImage.size.width, norImage.size.height);
    }
    if (selImg){
        UIImage* selImage = [UIImage imageNamed:selImg];
        [button setImage:selImage forState:UIControlStateHighlighted];
    }
    if (title) {
        CGSize strSize = [title sizeWithFont:[UIFont boldSystemFontOfSize:16]];
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        frame.size.width = MAX(frame.size.width, strSize.width + 10);
        frame.size.height = strSize.height+5;
        if (isBorder) {
            button.layer.cornerRadius = 2.f;
            button.layer.masksToBounds = YES;
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            button.layer.borderWidth = 0.5f;
        }
        button.frame = frame;
    }
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* tmpBarBtnItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    return tmpBarBtnItem;
}

@end
