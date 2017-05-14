//
//  HXOrganizationDetailAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationDetailAPI.h"

@implementation HXOrganizationDetailAPI
+ (instancetype)getOrganizationListWithmechanism_id:(NSString *)mechanism_id{
    
    HXOrganizationDetailAPI *api = [HXOrganizationDetailAPI new];
    api.subUrl = API_mechanism_detail;
    if (mechanism_id) {
        [api.parameters setObject:mechanism_id forKey:@"mechanism_id"];
    }
    api.parametersAddToken = YES;
    
    return api;
}
@end
