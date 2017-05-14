//
//  HXOrganizationListAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationListAPI.h"

@implementation HXOrganizationListAPI
+ (instancetype)getOrganizationListWithLimit:(NSString*)limit{

    HXOrganizationListAPI *api = [HXOrganizationListAPI new];
    api.subUrl = API_mechanism_list;
    if (limit) {
        [api.parameters setObject:limit forKey:@"limit"];
    }
    api.parametersAddToken = NO;
    
    return api;


}
@end
