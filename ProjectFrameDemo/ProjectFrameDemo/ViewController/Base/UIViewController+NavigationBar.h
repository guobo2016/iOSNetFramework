//
//  IBBaseViewController+NavigationBar.h
//  ProjectFrameDemo
//
//  Created by 郭波 on 15/12/17.
//  Copyright © 2015年 XX_Company. All rights reserved.
//

@interface UIViewController (NavigationBar)

/**
 *  设置导航条标题
 *
 *  @param title 标题
 */
- (void)setNavTitle:(NSString *)title;
/**
 *  设置右边的UIBarItem
 *
 *  @param normalImg 图片
 *  @param selImg    点击图片
 *  @param title     标题
 *  @param action    事件函数
 */
- (void)setNavRightButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action;
/**
 *  设置左边的UIBarItem
 *
 *  @param normalImg 图片
 *  @param selImg    点击图片
 *  @param title     标题
 *  @param action    事件函数
 */
- (void)setNavLeftButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action;
/**
 *  设置左边的UIBarItem
 *
 *  @param normalImg 图片
 *  @param selImg    点击图片
 *  @param title     标题
 *  @param action    事件函数
 *  @praam isBorder  是否有边框
 */
- (void)setNavLeftButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action isBorder:(BOOL)isBorder;
/**
 *  设置右边的UIBarItem
 *
 *  @param normalImg 图片
 *  @param selImg    点击图片
 *  @param title     标题
 *  @param action    事件函数
 *  @praam isBorder  是否有边框
 */
-(void)setNavRightButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action isBorder:(BOOL)isBorder;
/**
 *  设置UIBarItem enable
 *
 *  @param enable enable
 */
- (void)setNavRightButtonEnable:(BOOL)enable;
/**
 *  设置UIBarItem enable
 *
 *  @param enable enable
 */
- (void)setNavLeftButtonEnable:(BOOL)enable;
/**
 *  设置返回按钮
 */
- (void)setNavBackArrow;
/**
 *  返回按钮点击事件
 *
 *  @param sender sender description
 */
- (void)navBackButtonClicked:(UIButton *)sender;
@end
