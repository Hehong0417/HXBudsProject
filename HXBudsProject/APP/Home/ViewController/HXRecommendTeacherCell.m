//
//  HXRecommendTeacherCell.m
//  haixing01
//
//  Created by n on 2017/2/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXRecommendTeacherCell.h"

@implementation HXRecommendTeacherCell


+(instancetype)initTeacherCellWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXRecommendTeacherCell" owner:nil options:nil] lastObject];
 
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.iconImgV lh_setCornerRadius:37 borderWidth:0 borderColor:nil];
    [self.attentionBtn lh_setCornerRadius:3 borderWidth:0 borderColor:nil];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
