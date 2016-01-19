//
//  LSBaseCell.m
//  
//
//  Created by Bob on 14-5-12.
//  Copyright (c) 2014年 Bob. All rights reserved.
//

#import "IB_BaseCell.h"

@interface IB_BaseCell()


@end

@implementation IB_BaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (instancetype)initCellFromXibWithTableView:(UITableView *)tableView
{
     id cell = [tableView dequeueReusableCellWithIdentifier:[[self class] cellIdentifier]];
     if (!cell)
     {
          cell = [[self class] loadFromXib];
     }
     return cell;
//     APPayResultHeaderCell *headerCell = [self.resultTableview dequeueReusableCellWithIdentifier:[APPayResultHeaderCell cellIdentifier]];
}

+ (id)loadFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil]lastObject];
}

+ (NSString*)cellIdentifier
{
    return NSStringFromClass(self);
}

+ (id)loadFromCellStyle:(UITableViewCellStyle)cellStyle
{
    return [[self alloc] initWithStyle:cellStyle reuseIdentifier:NSStringFromClass(self)];
}

- (void)awakeFromNib
{
     [super awakeFromNib];
}
-(void)layoutSubviews
{
     [super layoutSubviews];
     if (_isBottomLine) {
//          [Helper createBottomSeperatorLineView:self.contentView];
     }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

+(CGFloat)rowHeightForObject:(id)object
{
    return 0;
}
@end
