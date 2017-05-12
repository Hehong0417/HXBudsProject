//
//  HXWXPayAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/11.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXWXPayAPI.h"

@implementation HXWXPayAPI
+ (instancetype)wxPayWithopcash:(NSString *)opcash wxpaytype:(NSString *)wxpaytype{

    HXWXPayAPI *api = [self new];
    api.subUrl = [NSString stringWithFormat:@"%@/app/wxtopay/wxtopay_anon",API_HOST];
    if (opcash) {
        [api.parameters setObject:opcash forKey:@"opcash"];
    }
    if (wxpaytype) {
        [api.parameters setObject:wxpaytype forKey:@"wxpaytype"];
    }
    
    return api;
}
@end
