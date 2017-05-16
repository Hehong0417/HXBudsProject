
//
//  HXFollowOrganizationAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/16.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXFollowOrganizationAPI.h"

@implementation HXFollowOrganizationAPI
+(instancetype)followMechanismWithMechanism_id:(NSString *)mechanism_id state:(NSString *)state{
    
    HXFollowOrganizationAPI *api = [self new];
    api.subUrl = API_followmechanism_add;
    if (mechanism_id) {
        [api.parameters setObject:mechanism_id forKey:@"mechanism_id"];
    }
    if (state) {
        [api.parameters setObject:state forKey:@"state"];
        
    }
    return api;
}

@end
