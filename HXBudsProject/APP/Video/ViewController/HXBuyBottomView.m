//
//  HXBuyBottomView.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXBuyBottomView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@interface HXBuyBottomView ()<WXApiDelegate>

@end

@implementation HXBuyBottomView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        //        self.frame.size.width*0.28
        self.consultBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height)  target:self action:@selector(consultAction:) title:@"收藏" titleColor: kWhiteColor font:FONT(18) backgroundColor:APP_COMMON_COLOR];
        
        [self addSubview:self.consultBtn];
        //     self.frame.size.width*0.72
        self.buyCourseBtn = [UIButton lh_buttonWithFrame:CGRectMake(SCREEN_WIDTH - self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height)target:self action:@selector(buyCourseAction:) title:@"赞赏" titleColor:kWhiteColor font:FONT(18) backgroundColor: RGB(255,168,37)];
        
        [self addSubview:self.buyCourseBtn];
        
        
    }
    
    return self;
    
}
- (void)consultAction:(UIButton *)btn{
    
    
    
    
}
- (void)buyCourseAction:(UIButton *)btn{
    
    //    self.shareBlock();
    //赞赏
    //-----支付宝支付------
    NSString *appScheme = @"alipay_mengya";
    
    // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = @"";
    
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSString * sc = resultDic[@"memo"];
        NSLog(@"reslut = %@",[sc stringByRemovingPercentEncoding]);

    }];
    
   //----微信支付-----
   
    PayReq * req = [[PayReq alloc] init];
    req.partnerId           = @"服务器给的partnerId";
    req.prepayId            = @"服务器给的prepayId";
    req.nonceStr            = @"服务器给的nonceStr";
    req.timeStamp           = 0;
    req.package             = @"服务器给的package";
    req.sign                = @"服务器给的sign";
   BOOL success =  [WXApi sendReq:req];
    //日志输出
    NSLog(@"partid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//    if (success) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"支付成功" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [self.vc dismissViewControllerAnimated:YES completion:nil];
//        }];
//        [alert addAction:action];

//        [self.vc presentViewController:alert animated:YES completion:nil];
        
//    }else {
    
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"支付失败" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [self.vc dismissViewControllerAnimated:YES completion:nil];
//        }];
//        [alert addAction:action];
//
//        [self.vc presentViewController:alert animated:YES completion:nil];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"支付失败"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                                  otherButtonTitles:@"确定", nil];
        alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        [alertView show];

//    }
}
//微信支付回调
- (void)onResp:(BaseResp *)resp  {






}
@end
