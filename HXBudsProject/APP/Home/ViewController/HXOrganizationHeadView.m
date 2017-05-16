//
//  HXOrganizationHeadView.m
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationHeadView.h"
#import "HXIndividualWorksVC.h"
#import "HXMapVC.h"


@implementation HXOrganizationHeadView

+ (instancetype)initOrganizationHeadViewWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXOrganizationHeadView" owner:nil options:nil] lastObject];
}
- (IBAction)backAction:(UIButton *)sender {
    
    [self.nav popVC];
}
- (void)awakeFromNib {

    [super awakeFromNib];
    [self.organizationIco lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    
    [self.attentionBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    [self.attentionBtn setTitleColor:kWhiteColor forState:UIControlStateSelected];
    [self.attentionBtn lh_setBackgroundColor:APP_COMMON_COLOR forState:UIControlStateSelected];
    [self.attentionBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [self.attentionBtn setTitleColor:APP_COMMON_COLOR forState:UIControlStateNormal];
    [self.attentionBtn lh_setBackgroundColor:kWhiteColor forState:UIControlStateNormal];
    [self.attentionBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
//    //个人作品
//    [self.individualWorksView setTapActionWithBlock:^{
//        
//        [self.nav pushVC:[HXIndividualWorksVC new]];
//        
//    }];
}


- (IBAction)attentionAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.attentionBtn lh_setCornerRadius:3 borderWidth:0 borderColor:APP_COMMON_COLOR];
        
    }else{
        [self.attentionBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    }
    self.followSelectedBlock(sender.selected);
    
}

- (void)setPdModel:(HXPdModel *)pdModel {
    
    _pdModel= pdModel;
    
    self.nickName.text = pdModel.nickname;
    
    [self.organizationIco sd_setImageWithURL:[NSURL URLWithString:kAPITeacherImageFromUrl(pdModel.the_headportrait)] placeholderImage:[UIImage imageNamed:@"person_ico"]];
//    NSString *followtenum = pdModel.followtenum?pdModel.followtenum:@"0";
//    self.followtenum.text = [NSString stringWithFormat:@"%@粉丝",followtenum];
    self.introduce.text = pdModel.hobby;
}
- (void)setModel:(HXOrganizationPdModel *)model {

    _model = model;
    [self.organizationIco sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.mechanism_logo)] placeholderImage:[UIImage imageNamed:@"person_ico"]];
    self.nickName.text = model.mechanism_name;
    self.introduce.text = model.mechanism_desc;

}

@end
