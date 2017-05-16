//
//  HXOrganizationCourseAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/16.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationCourseAPI.h"

@implementation HXOrganizationCourseAPI
+(instancetype)getOrganizationVideoWithmechanism_id:(NSString *)mechanism_id Limit:(NSNumber *)limit{
    HXOrganizationCourseAPI *api = [HXOrganizationCourseAPI new];
    api.subUrl = API_GET_CURRICULUM;
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
