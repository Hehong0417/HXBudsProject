//
//  HXPerformanceActivitiesCell.m
//  haixing01
//
//  Created by n on 2017/2/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXPerformanceActivitiesCell.h"

@implementation HXPerformanceActivitiesCell

+(instancetype)initActivityCellWithXib{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"HXPerformanceActivitiesCell" owner:nil options:nil] lastObject];
    
    
}
- (void)awakeFromNib {

    [super awakeFromNib];
    
    [self.endBtn lh_setCornerRadius:3 borderWidth:1 borderColor:kRedColor];
    self.endBtn.titleLabel.textColor = kRedColor;
    
}

@end
