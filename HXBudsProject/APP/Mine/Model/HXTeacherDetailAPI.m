//
//  HXTeacherDetailAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/25.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXTeacherDetailAPI.h"

@implementation HXTeacherDetailAPI

+ (instancetype)getTeacherDetailWithTeacherId:(NSString *)teacherId users_id:(NSString *)users_id{

    HXTeacherDetailAPI *api = [HXTeacherDetailAPI new];
    api.subUrl = API_GET_TEACHER_DDETAIL;
    if (teacherId) {
        [api.parameters setObject:teacherId forKey:@"theteacher_id"];
    }
    if (users_id) {
        [api.parameters setObject:users_id forKey:@"users_id"];
    }
    return api;

}


@end
