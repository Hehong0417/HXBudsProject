//
//  HXEditPwdAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/11.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXEditPwdAPI.h"

@implementation HXEditPwdAPI

+ (instancetype)editPwdWithOldpassword:(NSString *)oldpassword NewPwd:(NSString *)password{
    
    HXEditPwdAPI *api = [HXEditPwdAPI new];
    api.subUrl = API_GET_EDIT_PWD;
    if (oldpassword) {
        [api.parameters setObject:oldpassword forKey:@"oldpassword"];
    }
    if (password) {
        [api.parameters setObject:password forKey:@"password"];
    }
    api.parametersAddToken = YES;
    return api;
    
    
}
@end
