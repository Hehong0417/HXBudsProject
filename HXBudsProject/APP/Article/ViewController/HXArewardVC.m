//
//  HXArewardVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/12.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXArewardVC.h"
#import "HXArewardCell.h"
#import "HXArewardCellOne.h"
#import "HXappreciationAPI.h"
#import "HXWXPayAPI.h"
#import "WXApi.h"

@interface HXArewardVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,WXApiDelegate>

@property (nonatomic, strong)   UITableView *accountReChargeTable;
@property (nonatomic, strong)   NSString *money;
@property (nonatomic, strong)   UITextField *moneyTextfiled;
@property (nonatomic, strong)   NSString *inputmoney;

@end

@implementation HXArewardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"打赏";
    //tableView
    self.accountReChargeTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStylePlain];
    self.accountReChargeTable.delegate = self;
    self.accountReChargeTable.dataSource = self;
    self.accountReChargeTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.accountReChargeTable];
    [self.accountReChargeTable registerClass:[HXArewardCell class] forCellReuseIdentifier:@"HXArewardCell"];
    [self.accountReChargeTable registerClass:[HXArewardCellOne class] forCellReuseIdentifier:@"HXArewardCellOne"];
    //马上充值
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) backColor:kWhiteColor];
    
    UIButton *reChargeBtn = [UIButton lh_buttonWithFrame:CGRectMake(35, 27, SCREEN_WIDTH - 70, 35) target:self action:@selector(reChargeAction) title:@"确认支付" titleColor:kWhiteColor font:FONT(16) backgroundColor:APP_COMMON_COLOR];
    [reChargeBtn lh_setCornerRadius:3 borderWidth:0 borderColor:nil];
    [footView addSubview:reChargeBtn];
    self.accountReChargeTable.tableFooterView = footView;
}
//
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
   self.money = @"";
    HXArewardCell *cell = (HXArewardCell *)[self.accountReChargeTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    for (NSInteger i = 0; i<6; i++) {
        [cell.tabControl collectionView:cell.tabControl.collectionView didDeselectItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    }
  
    return YES;

}

#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
          
            HXArewardCellOne *cell = [tableView dequeueReusableCellWithIdentifier:@"HXArewardCellOne"];
            
            return cell;
            
        }else {
            
            HXArewardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXArewardCell"];
            cell.tabControl.selectTabControlBlock = ^(NSString *money) {
                NSLog(@"money-%@",money);
                self.money = money;
                [self.accountReChargeTable reloadData];
            };
            return cell;
        }

        
    }else if(indexPath.section == 1){
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            self.moneyTextfiled = [UITextField lh_textFieldWithFrame:CGRectMake(100, 0, SCREEN_WIDTH - 150, 44) placeholder:@"0.00" font:FONT(14) textAlignment:NSTextAlignmentRight backgroundColor:kWhiteColor];
            self.moneyTextfiled.delegate = self;
            [cell.contentView addSubview:self.moneyTextfiled];
            
            self.money = self.moneyTextfiled.text;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"其他金额";
        return cell;
    }
    
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }else{
    
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            return 165;
            
        }else{
            
            return 160;
        }
    }else{
    
        return 44;
    }
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    HXOpusDetailVC *vc = [[HXOpusDetailVC alloc]init];
    //    [self.navigationController pushVC:vc];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (void)reChargeAction {

     UITableViewCell *cell = [self.accountReChargeTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    for (UIView *subView in cell.contentView.subviews) {
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField *textFiled = (UITextField *)subView;
            self.inputmoney = textFiled.text;
       
            }
    }
    if (self.money) {
        [[[HXappreciationAPI appreciationarticleWitharticle_id:self.article_id app_money:self.money] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
            NSString *transaction = responseObject[@"pd"][@"transaction"];
            if ([transaction isEqualToString:@"no"]) {
                //余额不足
                [[[HXWXPayAPI wxPayWithopcash:@"0.01" wxpaytype:@"APP"] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
                    
                    [self payWithResponse:responseObject];
                    
                }];
            }else if([transaction isEqualToString:@"ok"]){
            
                [SVProgressHUD showSuccessWithStatus:@"打赏成功"];
                [self.navigationController popVC];
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:@"打赏失败"];
            
            }
            
               }];
    }else {
    
        [[[HXappreciationAPI appreciationarticleWitharticle_id:self.article_id app_money:self.inputmoney] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
            NSString *transaction = responseObject[@"pd"][@"transaction"];
            if ([transaction isEqualToString:@"no"]) {
                //余额不足
                [[[HXWXPayAPI wxPayWithopcash:@"0.01" wxpaytype:@"APP"] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
                    
                    [self payWithResponse:responseObject];
                    
                }];
            }else if([transaction isEqualToString:@"ok"]){
                
                [SVProgressHUD showSuccessWithStatus:@"打赏成功"];
                [self.navigationController popVC];
            }else{
                [SVProgressHUD showSuccessWithStatus:@"打赏失败"];
            }
        }];
    }


       NSLog(@"self.money-%@",self.money);
       NSLog(@"self.inputmoney-%@",self.inputmoney);

    
}
- (void)payWithResponse:(NSDictionary *)response{
    
    PayReq * req = [[PayReq alloc] init];
    req.partnerId           = response[@"pd"][@"partner"];
    req.prepayId            = response[@"pd"][@"prepay_id"];
    req.nonceStr            = response[@"pd"][@"nonceStr"];
    NSString *timeStamp = response[@"pd"][@"timeStamp"];
    req.timeStamp           = timeStamp.intValue;
    req.package             = response[@"pd"][@"package"];
    req.sign                = response[@"pd"][@"finalsign"];
    BOOL success =  [WXApi sendReq:req];
    //日志输出
    NSLog(@"partid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\n sign=%@",req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    NSLog(@"success--%d",success);
    
}
//微信支付回调
- (void)onResp:(BaseResp *)resp  {
    
    
    
    
}





@end
