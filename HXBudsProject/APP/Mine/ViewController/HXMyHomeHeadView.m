//
//  HXMyHomeHeadView.m
//  HXBudsProject
//
//  Created by n on 2017/3/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyHomeHeadView.h"
#import "HXPersonInfoVC.h"
#import "HXMesssageOneVC.h"


@implementation HXMyHomeHeadView

-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self.editBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    [self.messageBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    
    self.editBtn.adjustsImageWhenHighlighted = NO;
    self.messageBtn.adjustsImageWhenHighlighted = NO;
    [self.ico lh_setCornerRadius:30 borderWidth:0 borderColor:nil];
}
+ (instancetype)initMyHomeHeadViewWithXib{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"HXMyHomeHeadView" owner:self options:nil] lastObject];
    
    
}
- (IBAction)editAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (self.isMyHomeInfo) {
        HXPersonInfoVC *vc2 = [HXPersonInfoVC new];
        [self.nav pushVC:vc2];
        
    }else {
        
        [sender lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    }
    
}

- (IBAction)messageAction:(UIButton *)sender {
    
    if (self.isMyHomeInfo) {
        
        HXMesssageOneVC *vc1 = [HXMesssageOneVC new];
        [self.nav pushVC:vc1];
        
    }else{
        
    }
    
}
- (void)setIsMyHomeInfo:(BOOL)isMyHomeInfo {
    
    _isMyHomeInfo = isMyHomeInfo;
    if (isMyHomeInfo) {
        
        [self setBtnInfoWithMyHomeInfo];
    }else{
        
        [self setBtnInfoWithHisHomeInfo];
        
    }
    
}
- (void)setBtnInfoWithMyHomeInfo{
    
    //编辑按钮
    [self.editBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:APP_COMMON_COLOR forState:UIControlStateNormal];
    [self.editBtn lh_setBackgroundColor:kWhiteColor forState:UIControlStateNormal];
    
    [self.editBtn setTitle:@"编辑" forState:UIControlStateSelected];
    [self.editBtn setTitleColor:APP_COMMON_COLOR forState:UIControlStateSelected];
    [self.editBtn lh_setBackgroundColor:kWhiteColor forState:UIControlStateSelected];
    
    //消息按钮
    [self.messageBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    [self.messageBtn setTitle:@"消息" forState:UIControlStateNormal];
    [self.messageBtn setTitleColor:APP_COMMON_COLOR forState:UIControlStateNormal];
    [self.messageBtn lh_setBackgroundColor:kWhiteColor forState:UIControlStateSelected];
    
    [self.messageBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    [self.messageBtn setTitle:@"消息" forState:UIControlStateSelected];
    [self.messageBtn setTitleColor:APP_COMMON_COLOR forState:UIControlStateSelected];
    [self.messageBtn lh_setBackgroundColor:kWhiteColor forState:UIControlStateSelected];
    
}
- (void)setBtnInfoWithHisHomeInfo {
    
    //+关注
    [self.editBtn lh_setCornerRadius:3 borderWidth:0 borderColor:APP_COMMON_COLOR];
    [self.editBtn setTitle:@"+关注" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.editBtn lh_setBackgroundColor:APP_COMMON_COLOR forState:UIControlStateNormal];
    
    [self.editBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [self.editBtn setTitleColor:APP_COMMON_COLOR forState:UIControlStateSelected];
    [self.editBtn lh_setBackgroundColor:kWhiteColor forState:UIControlStateSelected];
    //消息按钮
    [self.messageBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    [self.messageBtn setTitle:@"消息" forState:UIControlStateNormal];
    [self.messageBtn setTitleColor:APP_COMMON_COLOR forState:UIControlStateNormal];
    [self.messageBtn lh_setBackgroundColor:kWhiteColor forState:UIControlStateNormal];
    
    [self.messageBtn setTitle:@"消息" forState:UIControlStateSelected];
    [self.messageBtn setTitleColor:APP_COMMON_COLOR forState:UIControlStateSelected];
    [self.messageBtn lh_setBackgroundColor:kWhiteColor forState:UIControlStateSelected];
    
}

- (void)setPdModel:(HXPdModel *)pdModel {

    _pdModel= pdModel;
    
    self.nickName.text = pdModel.nickname;
    
    [self.ico sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(pdModel.the_headportrait)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
    NSString *followtenum = pdModel.followtenum?pdModel.followtenum:@"0";
    self.followtenum.text = [NSString stringWithFormat:@"%@粉丝",followtenum];
    self.introduce.text = pdModel.hobby;
}

@end
