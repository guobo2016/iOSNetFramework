//
//  IBBaseViewController.m
//  _6.0
//
//  Created by Bob on 13-10-21.
//  Copyright (c) 2013年 Bob. All rights reserved.
//
#import "IBBaseViewController.h"
#import "MBProgressHUD+Add.h"

@interface IBBaseViewController ()<UIGestureRecognizerDelegate>
{
}

@property (strong,nonatomic)     MBProgressHUD *      progressView;
@end

@implementation IBBaseViewController
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self createNav];
    }
    return self;
}

//- (void)

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupViews];
    [self setupDatas];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}
-(void)createNav
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = NO;
}

-(void)setupViews
{
    _progressView = [[MBProgressHUD alloc] initWithView:self.view];
    _progressView.dimBackground = NO;
    self.view.backgroundColor = RGB(247, 247, 247);
    [self.view addSubview:_progressView];

}
-(void)setupDatas
{
    
}

#pragma mark public method

- (void)showProgressViewWithTitle:(NSString *)title
{
    if (title){
        _progressView.labelText = title;
    }
    [_progressView show:YES];
    [self.view bringSubviewToFront:_progressView];
}

- (void)hideProgressView
{
    [_progressView hide:YES];
}


@end
