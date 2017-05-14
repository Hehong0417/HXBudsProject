//
//  HXAccountReChargeCell.m
//  HXBudsProject
//
//  Created by n on 2017/5/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXAccountReChargeCell.h"
@implementation HXAccountReChargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
     {

         [self.contentView addSubview:self.tabControl];
    }

    return self;

}

- (HXTabControl *)tabControl {
    if (!_tabControl) {
        _tabControl = [[HXTabControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
        _tabControl.titleStr = @"充值金额";
        _tabControl.moneyArr = @[@"20",@"50",@"100",@"200",@"300",@"500"];
    }
    return _tabControl;
}

@end
