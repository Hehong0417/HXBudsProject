//
//  HXAdvertisementAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/18.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXAdvertisementAPI.h"

@implementation HXAdvertisementAPI

+ (instancetype)getAdvertisement{

    HXAdvertisementAPI *api = [self new];
    
    api.subUrl = API_GET_LIST_anon;
    api.parametersAddToken = NO;
    return api;

}


@end
