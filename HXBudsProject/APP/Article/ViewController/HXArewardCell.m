//
//  HXArewardCell.m
//  HXBudsProject
//
//  Created by n on 2017/5/12.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXArewardCell.h"

@implementation HXArewardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
        _tabControl.moneyArr = @[@"2.0",@"5.0",@"10.0",@"50.0",@"100",@"200"];
    }
    return _tabControl;
}

@end
