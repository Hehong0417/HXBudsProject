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
#import "HXMyAccountInfoVC.h"
#import "WXApiManager.h"
#import "HJUser.h"



@interface HXAccountReChargeVC ()<UITableViewDelegate,UITableViewDataSource,WXApiDelegate,WXApiManagerDelegate,SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic, strong)   UITableView *accountReChargeTable;
@property (nonatomic, strong)   NSString *money;
@property (nonatomic, copy)   NSString *productID;
@property (nonatomic, copy)  HJUser *user;


@end

@implementation HXAccountReChargeVC

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.user = [HJUser sharedUser];
  
}

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
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wxPaySucesscount) name:KWX_Pay_Sucess_Notification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wxPayFailcount) name:KWX_Pay_Fail_Notification object:nil];
    
    
    //Apple Pay
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    
}

#pragma mark - 微信支付

- (void)wxPaySucesscount{
    
    NSLog(@"******支付成功*******");
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)wxPayFailcount {
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showErrorWithStatus:@"充值失败"];
    
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
        
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showInfoWithStatus:@"请选择充值金额！"];
        return;
    }
    
    //测试账号
    if ([self.user.pd.users_id isEqualToString:@"3"]) {
        //**********Apple Pay*************
        if ([SKPaymentQueue canMakePayments]) {
            //是否允许程序内付费购买
            [[[HXWXPayAPI wxPayWithopcash:self.money wxpaytype:@"APP"] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
                if (error==nil) {
                    [self payWithResponse:responseObject];
                }
                
            }];
            NSLog(@"允许程序内付费购买");
        }
        else
        {
            NSLog(@"不允许程序内付费购买");
            UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"您的手机没有打开程序内付费购买"
                                                               delegate:nil cancelButtonTitle:NSLocalizedString(@"关闭",nil) otherButtonTitles:nil];
            [alerView show];
        }
        
        //****************************
    }else{
    //其他账号
        //****************微信 pay****************
        [[[HXWXPayAPI wxPayWithopcash:@"0.01" wxpaytype:@"APP"] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
            if (error == nil) {
                [self payWithResponse:responseObject];
            }
    
        }];
        NSLog(@"self.money-%@",self.money);
    
        //****************************
    
    }

}

- (void)payWithResponse:(NSDictionary *)response{
    //测试账号
    if ([self.user.pd.users_id isEqualToString:@"3"]) {

    //Apple  Pay
    NSLog(@"---------请求对应的产品信息------------");
    NSArray *product = nil;
    product = [[NSArray alloc] initWithObjects:ProductID_MENYA,nil];
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request=[[SKProductsRequest alloc] initWithProductIdentifiers: nsset];
    request.delegate=self;
    [request start];
    
    }else{
    //其他账号
            //微信支付
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
  
}
#pragma mark - <SKProductsRequestDelegate>

//收到商品信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSLog(@"-----------收到产品反馈信息--------------");
    NSArray *myProduct = response.products;
    NSLog(@"产品Product ID:%@",response.invalidProductIdentifiers);
    NSLog(@"产品付费数量: %d", (int)[myProduct count]);
    // populate UI
    for(SKProduct *product in myProduct){
        NSLog(@"product info");
        NSLog(@"SKProduct 描述信息%@", [product description]);
        NSLog(@"产品标题 %@" , product.localizedTitle);
        NSLog(@"产品描述信息: %@" , product.localizedDescription);
        NSLog(@"价格: %@" , product.price);
        NSLog(@"Product id: %@" , product.productIdentifier);
    }

    SKPayment *payment = nil;
    if (myProduct.count > 0) {
        payment  = [SKPayment paymentWithProduct:myProduct[0]];    //支付6
        NSLog(@"---------发送购买请求------%@------",myProduct[0]);
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    
}
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"-------弹出错误信息----------");
    UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert",NULL) message:[error localizedDescription]
                                                       delegate:nil cancelButtonTitle:NSLocalizedString(@"Close",nil) otherButtonTitles:nil];
    [alerView show];
    
}
-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction{
    NSLog(@"-----PurchasedTransaction----");
    NSArray *transactions =[[NSArray alloc] initWithObjects:transaction, nil];
    [self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];
}
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions//交易结果
{
    NSLog(@"-----paymentQueue--------");
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:{//交易完成
                [self completeTransaction:transaction];
                NSLog(@"-----交易完成 --------");
                
                UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@""
                                                                    message:@"购买成功"
                                                                   delegate:nil cancelButtonTitle:NSLocalizedString(@"关闭",nil) otherButtonTitles:nil];
                
                [alerView show];
                
            } break;
            case SKPaymentTransactionStateFailed://交易失败
            { [self failedTransaction:transaction];
                NSLog(@"-----交易失败 ---%@-----",transaction.error);
                UIAlertView *alerView2 =  [[UIAlertView alloc] initWithTitle:@"提示"
                                                                     message:@"购买失败，请重新尝试购买"
                                                                    delegate:nil cancelButtonTitle:NSLocalizedString(@"关闭",nil) otherButtonTitles:nil];
                
                [alerView2 show];
                
            }break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
                [self restoreTransaction:transaction];
                NSLog(@"-----已经购买过该商品 --------");
            case SKPaymentTransactionStatePurchasing:      //商品添加进列表
                NSLog(@"-----商品添加进列表 --------");
                break;
            default:
                break;
        }
    }
}
- (void) completeTransaction: (SKPaymentTransaction *)transaction

{
    NSLog(@"-----completeTransaction--------");
    // Your application should implement these two methods.
    NSString *product = transaction.payment.productIdentifier;
    if ([product length] > 0) {
        
        NSArray *tt = [product componentsSeparatedByString:@"."];
        NSString *bookid = [tt lastObject];
        if ([bookid length] > 0) {
            [self recordTransaction:bookid];
            [self provideContent:bookid];
        }
    }
    
    // Remove the transaction from the payment queue.
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

//记录交易
-(void)recordTransaction:(NSString *)product{
    NSLog(@"-----记录交易--------");
}

//处理下载内容
-(void)provideContent:(NSString *)product{
    NSLog(@"-----下载--------");
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction{
    NSLog(@"失败");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}
-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction{
    
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    NSLog(@" 交易恢复处理");
    
}

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    NSLog(@"-------paymentQueue----");
}

#pragma mark connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"%@",  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    switch([(NSHTTPURLResponse *)response statusCode]) {
        case 200:
        case 206:
            break;
        case 304:
            break;
        case 400:
            break;
        case 404:
            break;
        case 416:
            break;
        case 403:
            break;
        case 401:
        case 500:
            break;
        default:
            break;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"test");
}

-(void)dealloc
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];//解除监听
    
}
//*******************************//


- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


@end
