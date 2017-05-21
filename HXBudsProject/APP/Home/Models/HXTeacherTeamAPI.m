//
//  HXTeacherTeamAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXTeacherTeamAPI.h"

@implementation HXTeacherTeamAPI
+ (instancetype)getTeacherTeamWithmechanism_id:(NSString *)mechanism_id{

    HXTeacherTeamAPI *api = [HXTeacherTeamAPI new];
    api.subUrl = API_teacherteam_list;
    if (mechanism_id) {
        [api.parameters setObject:mechanism_id forKey:@"mechanism_id"];
    }
    api.parametersAddToken = YES;
    
    return api;

}

@end
