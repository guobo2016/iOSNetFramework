//
//  BaseView.m
//  Hands-Seller
//
//  Created by guobo on 14-4-18.
//  Copyright (c) 2014年 Bob. All rights reserved.
//

#import "IBBaseView.h"

@implementation IBBaseView
+(id)loadFromXib
{
    NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil];
    return [nibArr lastObject];
}

-(void)viewLayoutWithData:(id)data{
    
    
}
+(CGFloat)rowHeightForObject:(id)object
{
    return 0;
}

@end
