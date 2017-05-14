//
//  HXwithdrawalsAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXwithdrawalsAPI.h"

@implementation HXwithdrawalsAPI

+ (instancetype)withdrawWithMoney:(NSString *)with_money with_acc:(NSString *)with_acc{

    HXwithdrawalsAPI *api = [HXwithdrawalsAPI new];
    api.subUrl = API_GET_withdrawals;
    if (with_money) {
        [api.parameters setObject:with_money forKey:@"with_money"];
    }
    if (with_acc) {
        [api.parameters setObject:with_acc forKey:@"with_acc"];
    }
    api.parametersAddToken = YES;
    return api;

}
@end
