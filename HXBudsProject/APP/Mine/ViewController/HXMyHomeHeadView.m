//
//  HXMyHomeHeadView.m
//  HXBudsProject
//
//  Created by n on 2017/3/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyHomeHeadView.h"
#import "HXPersonInfoVC.h"
#import "HXMessageVC.h"


@implementation HXMyHomeHeadView

-(void)awakeFromNib {
    [super awakeFromNib];

    [self.editBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    [self.messageBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    
}
+ (instancetype)initMyHomeHeadViewWithXib{

  return [[[NSBundle mainBundle]loadNibNamed:@"HXMyHomeHeadView" owner:self options:nil] lastObject];


}
- (IBAction)editAction:(UIButton *)sender {

    HXPersonInfoVC *vc2 = [HXPersonInfoVC new];
    [self.nav pushVC:vc2];


}

- (IBAction)messageAction:(UIButton *)sender {
    
    
    HXMessageVC *vc1 = [HXMessageVC new];
    [self.nav pushVC:vc1];
  
    
}
- (void)setIsMyHomeInfo:(BOOL)isMyHomeInfo {

    _isMyHomeInfo = isMyHomeInfo;
    if (isMyHomeInfo) {

        [self setBtnInfoWithMyHomeInfo];
        
    }

}
- (void)setBtnInfoWithMyHomeInfo{

    
    //编辑按钮
    [self.editBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:APP_COMMON_COLOR forState:UIControlStateNormal];
    
    [self.messageBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    [self.messageBtn setTitle:@"消息" forState:UIControlStateNormal];
    [self.messageBtn setTitleColor:APP_COMMON_COLOR forState:UIControlStateNormal];


}

@end
