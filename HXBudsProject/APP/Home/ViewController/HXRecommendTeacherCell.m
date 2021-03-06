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
    [self.attentionBtn lh_setCornerRadius:3 borderWidth:1 borderColor:kLightGrayColor];
    [self.attentionBtn setTitleColor:kWhiteColor forState:UIControlStateSelected];
    [self.attentionBtn lh_setBackgroundColor:APP_COMMON_COLOR forState:UIControlStateSelected];
     [self.attentionBtn setTitleColor:kLightGrayColor forState:UIControlStateNormal];
     [self.attentionBtn lh_setBackgroundColor:kWhiteColor forState:UIControlStateNormal];
    [self.attentionBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
    [self.attentionBtn setTitle:@"已关注" forState:UIControlStateSelected];
 
}

- (IBAction)attentionAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        [self.attentionBtn lh_setCornerRadius:3 borderWidth:0 borderColor:nil];

    }else{
    
     [self.attentionBtn lh_setCornerRadius:3 borderWidth:1 borderColor:kLightGrayColor];
    }
    
}

@end
