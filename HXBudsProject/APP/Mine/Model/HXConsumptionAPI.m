//
//  HXConsumptionAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/11.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXConsumptionAPI.h"

@implementation HXConsumptionAPI
+ (instancetype)getConsumptionData{

    HXConsumptionAPI *api = [HXConsumptionAPI new];
    api.subUrl = API_GET_TRANSACTION;
    api.parametersAddToken = YES;
    return api;
}

@end
