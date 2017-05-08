//
//  HXWXLoginAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXWXLoginAPI.h"

@implementation HXWXLoginAPI

+ (instancetype)WXloginWithoptionid:(NSString *)optionid headportrait:(NSString *)headportrait sex:(NSString *)sex nickname:(NSString *)nickname{

    HXWXLoginAPI *api = [self new];
    api.subUrl = API_WX_LOGIN;
    if (optionid) {
        [api.parameters setObject:optionid forKey:@"openid"];
    }
    if (headportrait) {
        [api.parameters setObject:headportrait forKey:@"headportrait"];
    }
    if (sex) {
        [api.parameters setObject:sex forKey:@"sex"];
    }
    if (nickname) {
        [api.parameters setObject:nickname forKey:@"nickname"];
    }
    api.parametersAddToken = NO;
    return api;

}
@end
