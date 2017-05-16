//
//  HXOrganizationListAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationListAPI.h"

@implementation HXOrganizationListAPI
+ (instancetype)getOrganizationListWithmechanism_id:(NSString *)mechanism_id Limit:(NSString*)limit{

    HXOrganizationListAPI *api = [HXOrganizationListAPI new];
    api.subUrl = API_mechanism_list;
    if (limit) {
        [api.parameters setObject:limit forKey:@"limit"];
    }
    if (mechanism_id) {
        [api.parameters setObject:mechanism_id forKey:@"mechanism_id"];
    }
    api.parametersAddToken = NO;
    
    return api;


}
@end
