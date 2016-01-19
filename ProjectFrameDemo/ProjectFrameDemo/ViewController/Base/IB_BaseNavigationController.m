//
//  LSBaseNavigationController.m
//  
//
//  Created by Bob on 14-4-17.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "IB_BaseNavigationController.h"
@interface IB_BaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>{
    BOOL _isEnablePop; //打开pop响应手势
}

@end

@implementation IB_BaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    __weak IB_BaseNavigationController *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    IB_BaseNavigationController* nvc = [super initWithRootViewController:rootViewController];
    nvc.delegate = self;
    [nvc.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarMetrics:UIBarMetricsDefault];

    return nvc;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if(self.viewControllers.count <= 1){
        return NO;
    }
    return _isEnablePop;
}

//控制根Controller不能右滑动
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

    _isEnablePop = YES;
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    /*
     if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
     self.interactivePopGestureRecognizer.enabled = NO;
     }
     */
    _isEnablePop = NO;
    [super pushViewController:viewController animated:animated];
    
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    return [super popToRootViewControllerAnimated:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    if ([self.viewControllers.lastObject isKindOfClass:[PPTViewController class]]) {
//        return UIInterfaceOrientationMaskLandscapeRight;
//    }
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}
// Override to allow orientations other than the default portrait orientation ios6.0
-(NSUInteger)supportedInterfaceOrientations{
//    if ([self.viewControllers.lastObject isKindOfClass:[PPTViewController class]]) {
//        return UIInterfaceOrientationMaskLandscapeRight;
//    }
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIViewController* vc = self.viewControllers.lastObject;
    if ([vc respondsToSelector:@selector(preferredStatusBarStyle)]) {
        return [vc preferredStatusBarStyle];
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden
{
    UIViewController* vc = self.viewControllers.lastObject;
    if ([vc respondsToSelector:@selector(prefersStatusBarHidden)]) {
        return [vc prefersStatusBarHidden];
    }
    return NO;
}

@end
