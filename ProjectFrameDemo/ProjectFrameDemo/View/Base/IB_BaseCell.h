//
//  LSBaseCell.h
//  
//
//  Created by Bob on 14-5-12.
//  Copyright (c) 2014年 Bob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IB_BaseCell : UITableViewCell

@property (assign,nonatomic) NSInteger selectSection;
@property (assign,nonatomic) NSInteger selectIndex;
@property (assign,nonatomic) NSInteger totalCount;
@property (assign,nonatomic) float cellHeight;
@property (assign,nonatomic) BOOL    isBottomLine;

/**
 *  用xib创建Cell
 *
 *  @return self;
 */
+(id)loadFromXib;

/**
 *  用代码创建Cell时候设置的cellIdentifier
 *
 *  @return cellIdentifier;
 */
+(NSString*)cellIdentifier;
/**
 *  用代码创建Cell
 *
 *  @return self;
 */

+(id)loadFromCellStyle:(UITableViewCellStyle)cellStyle;

/**
 *  填充cell的对象
 *  子类去实现
 */

- (void)fillCellWithObject:(id)object;

/**
 *  计算cell高度
 *  子类去实现
 */

+ (CGFloat)rowHeightForObject:(id)object;
+ (instancetype)initCellFromXibWithTableView:(UITableView *)tableView;


@end
