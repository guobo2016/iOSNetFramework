//
//  BaseView.h
//  Hands-Seller
//
//  Created by guobo on 14-4-18.
//  Copyright (c) 2014年 Bob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBBaseView : UIView

+ (id)loadFromXib;

- (void)viewLayoutWithData:(id)data;

+ (CGFloat)rowHeightForObject:(id)object;

@end
