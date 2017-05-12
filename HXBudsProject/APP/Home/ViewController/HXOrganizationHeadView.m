//
//  HXOrganizationHeadView.m
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationHeadView.h"
#import "HXIndividualWorksVC.h"

@implementation HXOrganizationHeadView

+ (instancetype)initOrganizationHeadViewWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXOrganizationHeadView" owner:nil options:nil] lastObject];
}
- (IBAction)backAction:(UIButton *)sender {
    
    [self.nav popVC];
}
- (void)awakeFromNib {

    [super awakeFromNib];
    [self.attentionBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    [self.organizationIco lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    
    //个人作品
    [self.individualWorksView setTapActionWithBlock:^{
        
        [self.nav pushVC:[HXIndividualWorksVC new]];
        
    }];
    //地址
    [self.addressView setTapActionWithBlock:^{
        
        
    }];
   
}
- (void)setPdModel:(HXPdModel *)pdModel {
    
    _pdModel= pdModel;
    
    self.nickName.text = pdModel.nickname;
    
    [self.organizationIco sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(pdModel.the_headportrait)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
//    NSString *followtenum = pdModel.followtenum?pdModel.followtenum:@"0";
//    self.followtenum.text = [NSString stringWithFormat:@"%@粉丝",followtenum];
    self.introduce.text = pdModel.hobby;
}

@end
