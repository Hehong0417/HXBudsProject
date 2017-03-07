//
//  HXMyAccountInfoVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyAccountInfoVC.h"

@interface HXMyAccountInfoVC ()

@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UITextField *rechargeTextField;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
@property (weak, nonatomic) IBOutlet UIButton *alipayBtn;
@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;

@end

@implementation HXMyAccountInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];

   self.title = @"我的账户";
    
    [self.rechargeBtn lh_setCornerRadius:WidthScaleSize_H(20) borderWidth:0 borderColor:nil];

}


@end
