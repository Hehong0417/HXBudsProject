//
//  HXAccountReChargeVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXAccountReChargeVC.h"
#import "HXAccountReChargeCell.h"
#import "HXWXPayAPI.h"
#import "WXApi.h"

@interface HXAccountReChargeVC ()<UITableViewDelegate,UITableViewDataSource,WXApiDelegate>

@property (nonatomic, strong)   UITableView *accountReChargeTable;
@property (nonatomic, strong)   NSString *money;

@end

@implementation HXAccountReChargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户充值";
    //tableView
    self.accountReChargeTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStylePlain];
    self.accountReChargeTable.delegate = self;
    self.accountReChargeTable.dataSource = self;
    self.accountReChargeTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.accountReChargeTable];
    [self.accountReChargeTable registerClass:[HXAccountReChargeCell class] forCellReuseIdentifier:@"HXAccountReChargeCell"];
    
    //马上充值
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) backColor:kWhiteColor];
    
    UIButton *reChargeBtn = [UIButton lh_buttonWithFrame:CGRectMake(35, 27, SCREEN_WIDTH - 70, 35) target:self action:@selector(reChargeAction) title:@"马上充值" titleColor:kWhiteColor font:FONT(16) backgroundColor:APP_COMMON_COLOR];
    [reChargeBtn lh_setCornerRadius:3 borderWidth:0 borderColor:nil];
    [footView addSubview:reChargeBtn];
    self.accountReChargeTable.tableFooterView = footView;
}

#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = @"微信支付";
        return cell;
    }else {
        
        HXAccountReChargeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXAccountReChargeCell"];
        cell.tabControl.selectTabControlBlock = ^(NSString *money) {
            NSLog(@"money-%@",money);
            self.money = money;
        };
        return cell;
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 50;
    }else{
        
     return 160;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    HXOpusDetailVC *vc = [[HXOpusDetailVC alloc]init];
    //    [self.navigationController pushVC:vc];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (void)reChargeAction {

    if (!self.money) {
        [SVProgressHUD showInfoWithStatus:@"请选择充值金额！"];
        return;
    }
    
    [[[HXWXPayAPI wxPayWithopcash:@"0.01" wxpaytype:@"APP"] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {

        [self payWithResponse:responseObject];

    }];
    NSLog(@"self.money-%@",self.money);


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
