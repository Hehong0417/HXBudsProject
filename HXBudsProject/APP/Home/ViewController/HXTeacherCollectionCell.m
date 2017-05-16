//
//  HXTeacherCollectionCell.m
//  HXBudsProject
//
//  Created by n on 2017/4/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXTeacherCollectionCell.h"


@implementation HXTeacherCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    [self.iconImagV lh_setCornerRadius:37 borderWidth:0 borderColor:nil];
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
    self.followSelectedBlock(sender.selected);

}
- (void)setTeacherModel:(HXteacherVarListModel *)teacherModel {

    _teacherModel = teacherModel;
    
    [self.iconImagV sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(teacherModel.the_headportrait)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
   
    self.teacherNameLab.text = teacherModel.the_name;
    self.introduceLab.text = teacherModel.hobby;
    UIColor *backgroud = teacherModel.the_name ?kWhiteColor:KPlaceHoldColor;
    if (!teacherModel.the_name) {
        self.introduceLab.height = 21;
    }
//    if ([teacherModel.followState isEqualToString:@"yes"]) {
//        
//        self.attentionBtn.selected = YES;
//        [self.attentionBtn lh_setCornerRadius:3 borderWidth:0 borderColor:nil];
//
//    }else{
//        self.attentionBtn.selected = NO;
//        [self.attentionBtn lh_setCornerRadius:3 borderWidth:1 borderColor:kLightGrayColor];
//    }
    UIColor *introBackgroud = teacherModel.hobby ?kWhiteColor:KPlaceHoldColor;
    self.introduceLab.backgroundColor = introBackgroud;
    self.teacherNameLab.backgroundColor = backgroud;
}

@end
