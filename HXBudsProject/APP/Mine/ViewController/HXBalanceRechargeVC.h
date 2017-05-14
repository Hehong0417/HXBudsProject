//
//  HXBalanceRechargeVC.h
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBalanceRechargeVC : UIViewController

@property (strong, nonatomic)  NSString *balance;

@property (weak, nonatomic) IBOutlet UITextField *wechatAccountTextfield;

@property (weak, nonatomic) IBOutlet UITextField *moneyTextfield;
@property (weak, nonatomic) IBOutlet UIButton *allWithDrawBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitWithdrawBtn;
@property (weak, nonatomic) IBOutlet UILabel *disribLab;

@property (weak, nonatomic) IBOutlet UITextField *with_moneyTextFiled;
@end
