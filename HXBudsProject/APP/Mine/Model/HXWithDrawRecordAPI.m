//
//  HXWithDrawRecordAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXWithDrawRecordAPI.h"

@implementation HXWithDrawRecordAPI

+ (instancetype)getWithDrawRecordData{
    
    HXWithDrawRecordAPI *api = [HXWithDrawRecordAPI new];
    api.subUrl = API_withdrawals_list;
    api.parametersAddToken = YES;
    return api;
}
@end
