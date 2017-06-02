//
//  HXBalanceRechargeVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXBalanceRechargeVC.h"
#import "HXwithdrawalsAPI.h"


@interface HXBalanceRechargeVC ()<UITextFieldDelegate>

@end

@implementation HXBalanceRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];

     self.title = @"余额提现";

    self.with_moneyTextFiled.leftView = [UILabel lh_labelWithFrame:CGRectMake(0, 0, 30, 43) text:@"￥" textColor:kBlackColor font:FONT(22) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
    self.with_moneyTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.with_moneyTextFiled.delegate = self;
    self.disribLab.text = [NSString stringWithFormat:@"可用余额%@元,收取%%5手续费",self.balance?self.balance:@"0.00"];
}
- (IBAction)commmieWithdrawAction:(UIButton *)sender {
    
    
    if (self.wechatAccountTextfield.text.length == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showInfoWithStatus:@"请先输入微信号"];
    }else{
    
    if (self.with_moneyTextFiled.text.floatValue >self.balance.floatValue) {
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];

        [SVProgressHUD showInfoWithStatus:@"金额已超过可用提现金额"];
    }else if(self.with_moneyTextFiled.text.floatValue < 100){
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];

        [SVProgressHUD showInfoWithStatus:@"100元起提现"];
        
    }else{
        
        CGFloat money =  self.with_moneyTextFiled.text.floatValue;
        NSString *moneyStr;
        if (money >1) {
            moneyStr = [NSString stringWithFormat:@"%.2f",money*0.05];
        }else{
         moneyStr = [NSString stringWithFormat:@"%.2f",money];
        }
        [[[HXwithdrawalsAPI withdrawWithMoney:self.with_moneyTextFiled.text with_acc:self.wechatAccountTextfield.text] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
            if (error==nil) {
            NSString *withdrawals = responseObject[@"pd"][@"withdrawals"];
            if ([withdrawals isEqualToString:@"ok"]) {
                [SVProgressHUD setMinimumDismissTimeInterval:1.0];

                [SVProgressHUD showSuccessWithStatus:@"申请成功！"];
                [self.navigationController popVC];
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:1.0];

                [SVProgressHUD showSuccessWithStatus:@"申请失败！"];
            }
            }
        }];
        
          }
    }

}

- (IBAction)allWithDrawAction:(UIButton *)sender {
    
    self.with_moneyTextFiled.text =  self.balance;
    
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//
//    if (textField.text.length>0) {
//        
//        float balanceValue = textField.text.floatValue;
//        if (balanceValue >self.balance.floatValue) {
//            
//            self.disribLab.text = @"金额已超过可提现金额";
//        }else{
//            
//            float fee = balanceValue *0.001;
//            if (fee<0.1) {
//                fee = 0.1;
//            }
//            self.disribLab.text = [NSString stringWithFormat:@"服务费%.1f元",fee];
//        }
//        
//    }
//    return YES;
//}


@end
