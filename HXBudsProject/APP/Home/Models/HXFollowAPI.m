//
//  HXFollowAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/26.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXFollowAPI.h"

@implementation HXFollowAPI

+(instancetype)followTeacherWiththeteacherId:(NSString *)theteacher_id state:(NSString *)state{

    HXFollowAPI *api = [self new];
    api.subUrl = API_GET_FOLLOW_TEACHER;
    if (theteacher_id) {
        [api.parameters setObject:theteacher_id forKey:@"theteacher_id"];
    }
    if (state) {
        [api.parameters setObject:state forKey:@"state"];

    }
    return api;
}

@end
