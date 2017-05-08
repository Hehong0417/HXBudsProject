//
//  HXgetUserInfoAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/5.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXgetUserInfoAPI.h"

@implementation HXgetUserInfoAPI

+ (instancetype)getUserInfo{

    HXgetUserInfoAPI *api = [HXgetUserInfoAPI new];
    api.subUrl = API_GET_USER_INFO;
    return api;

}
@end
