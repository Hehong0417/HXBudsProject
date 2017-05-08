//
//  HXModifyUserInfoAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/5.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXModifyUserInfoAPI.h"

@implementation HXModifyUserInfoAPI

+ (instancetype)ModifyUserInfoWithNickname:(NSString *)nickname username:(NSString *)username  phone:(NSString *)phone  sex:(NSString *)sex age:(NSString *)age hobby:(NSString *)hobby{

    HXModifyUserInfoAPI *api = [HXModifyUserInfoAPI new];
    api.subUrl = API_GET_USER_SIMPLE_INFO;
    if (nickname) {
        [api.parameters setObject:nickname forKey:@"nickname"];
    }
    if (phone) {
        [api.parameters setObject:phone forKey:@"phone"];
    }
    if (username) {
        [api.parameters setObject:username forKey:@"username"];
    }
    if (sex) {
        [api.parameters setObject:sex forKey:@"sex"];
    }
    if (age) {
        [api.parameters setObject:age forKey:@"age"];
    }
    if (hobby) {
        [api.parameters setObject:hobby forKey:@"hobby"];
    }
    
    return api;



}

@end
