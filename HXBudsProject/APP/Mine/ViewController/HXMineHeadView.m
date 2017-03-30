//
//  HXMineHeadView.m
//  HXBudsProject
//
//  Created by n on 2017/3/2.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMineHeadView.h"
#import "HXPersonInfoVC.h"
#import "HXLoginVC.h"
#import "HXRegisterVC.h"

@implementation HXMineHeadView


+ (instancetype)initmineHeadViewWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXMineHeadView" owner:nil options:nil] lastObject];


}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.loginBtnView lh_setCornerRadius:15 borderWidth:0 borderColor:nil];
    [self.registerBtnView lh_setCornerRadius:15 borderWidth:0 borderColor:nil];
    self.loginBtnView.userInteractionEnabled = NO;;
    self.registerBtnView.userInteractionEnabled = NO;
    

}


- (IBAction)backAction:(UIButton *)sender {
    
    [self.nav pushVC:[HXPersonInfoVC new]];
    
    
}

- (IBAction)loginAction:(UIButton *)sender {
    
    [self.nav pushVC:[HXLoginVC new]];
    
}
- (IBAction)registerAction:(UIButton *)sender {
    
    [self.nav pushVC:[HXRegisterVC new]];
    
}


@end
