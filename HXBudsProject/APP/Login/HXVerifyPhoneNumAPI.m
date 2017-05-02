//
//  HXVerifyPhoneNumAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/28.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXVerifyPhoneNumAPI.h"

@implementation HXVerifyPhoneNumAPI

+ (instancetype)verifyPhoneNumWithPhoneNum:(NSString *)acc{

    HXVerifyPhoneNumAPI *api = [self new];
    api.subUrl = API_CHECK_PHONE;
    if (acc) {
        [api.parameters setObject:acc forKey:@"acc"];
    }
    return api;
}

@end
