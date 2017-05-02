//
//  HXIsLoginAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/28.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXIsLoginAPI.h"

@implementation HXIsLoginAPI

+ (instancetype)isLoginWithToken:(NSString *)token{

    HXIsLoginAPI *api = [self new];
    api.subUrl = API_IS_LOGIN;
//    if (token) {
//        [api.parameters setObject:token forKey:@"token"];
//    }
    api.parametersAddToken = YES;
    return api;
}

@end
