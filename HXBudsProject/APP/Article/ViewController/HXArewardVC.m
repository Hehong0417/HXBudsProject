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
#import "HXArticleDetailVC.h"

@interface HXArewardVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,WXApiDelegate>

@property (nonatomic, strong)   UITableView *accountReChargeTable;
@property (nonatomic, strong)   NSString *money;
@property (nonatomic, strong)   UITextField *moneyTextfiled;
@property (nonatomic, strong)   NSString *inputmoney;
@property (nonatomic, strong)   NSString *commitMoney;

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
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wxPaySucess) name:KWX_Article_Pay_Sucess_Notification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wxPayFail) name:KWX_Article_Pay_Fail_Notification object:nil];
}
//
- (void)wxPaySucess{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self appreciationRequest];
    
}
- (void)appreciationRequest{

    [[[HXappreciationAPI appreciationarticleWitharticle_id:self.article_id app_money:self.commitMoney] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        if (error==nil) {
            NSString *transaction = responseObject[@"pd"][@"transaction"];
            NSLog(@"文章打赏回调");
            if ([transaction isEqualToString:@"no"]) {
                
                [self appreciationRequest];
                
            }else if([transaction isEqualToString:@"ok"]){
                
                [[NSNotificationCenter defaultCenter] postNotificationName:KWX_UpdateIcon_Notification object:nil];
                [SVProgressHUD setMinimumDismissTimeInterval:1.0];
                [SVProgressHUD showSuccessWithStatus:@"打赏成功"];
                
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:1.0];
                [SVProgressHUD showSuccessWithStatus:@"打赏失败"];
            }
 
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
             [SVProgressHUD showSuccessWithStatus:@"打赏失败"];
        }
    }];

}

- (void)wxPayFail {
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showErrorWithStatus:@"打赏失败"];

}

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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else {
            
            HXArewardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXArewardCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
         
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
            self.moneyTextfiled.returnKeyType = UIReturnKeyDone;
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self.view endEditing:YES];
    
    return YES;
}
- (void)reChargeAction {

     UITableViewCell *cell = [self.accountReChargeTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    for (UIView *subView in cell.contentView.subviews) {
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField *textFiled = (UITextField *)subView;
            self.inputmoney = textFiled.text;
            }
    }
    if (self.money.floatValue == 0&&self.inputmoney.floatValue == 0 ) {
        
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showInfoWithStatus:@"金额必须大于0"];
        return;
    }
    if (self.money.floatValue > 0) {
        self.commitMoney = self.money;
        [[[HXappreciationAPI appreciationarticleWitharticle_id:self.article_id app_money:self.money] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
            if (error==nil) {
                
            NSString *transaction = responseObject[@"pd"][@"transaction"];
            
            if ([transaction isEqualToString:@"no"]) {
                NSLog(@"第一次");

                //余额不足
                [[[HXWXPayAPI wxPayWithopcash:self.money wxpaytype:@"APP"] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
                    
                    [self payWithResponse:responseObject];

                }];
            }else if([transaction isEqualToString:@"ok"]){
                [SVProgressHUD setMinimumDismissTimeInterval:1.0];

                [SVProgressHUD showSuccessWithStatus:@"打赏成功"];
                [self.navigationController popVC];
            }else{

                [SVProgressHUD setMinimumDismissTimeInterval:1.0];
               [SVProgressHUD showErrorWithStatus:@"请求超时"];
            
            }
            }
            
               }];
            

    }else if(self.inputmoney.floatValue>0){
        
        self.commitMoney = self.inputmoney;

        [[[HXappreciationAPI appreciationarticleWitharticle_id:self.article_id app_money:self.inputmoney] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
            
            if (error==nil) {

            NSString *transaction = responseObject[@"pd"][@"transaction"];
            
            if ([transaction isEqualToString:@"no"]) {
                NSLog(@"第一次");

                //余额不足
                [[[HXWXPayAPI wxPayWithopcash:self.inputmoney wxpaytype:@"APP"] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
                    if (error==nil) {
                        [self payWithResponse:responseObject];
                    }
                    
                }];
            }else if([transaction isEqualToString:@"ok"]){
                [SVProgressHUD setMinimumDismissTimeInterval:1.0];

                [SVProgressHUD showSuccessWithStatus:@"打赏成功"];
                [self.navigationController popVC];
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:1.0];

                [SVProgressHUD showSuccessWithStatus:@"打赏失败"];
            }
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
- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    NSLog(@"打赏控制器销毁了！！");
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
- (void)dealloc {
    

}

@end
