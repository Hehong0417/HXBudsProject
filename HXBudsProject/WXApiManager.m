//
//  WXApiManager.m
//  HXBudsProject
//
//  Created by n on 2017/5/25.
//  Copyright © 2017年 n. All rights reserved.
//

#import "WXApiManager.h"

@implementation WXApiManager

+ (instancetype)shareManager{

    static dispatch_once_t onceToken;
    static WXApiManager *instance;

    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc]init];
    });
    return instance;
}
- (void)dealloc {
    self.delegate = nil;
}
- (void)onResp:(BaseResp *)resp {
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvGetResp:)]) {
            PayResp *payResp = (PayResp *)resp;
            [_delegate managerDidRecvGetResp:payResp];
        }
//        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);

//        switch (resp.errCode) {
//            case WXSuccess:
//                strMsg = @"支付结果：成功！";
//                []
//                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
//                break;
//                
//            default:
//                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
//                break;
//        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
   }

}

@end
