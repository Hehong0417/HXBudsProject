//
//  HXHomeAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXTeacherListAPI.h"

@implementation HXTeacherListAPI

+ (instancetype)getTeacherListWithWithLimit:(NSNumber*)limit
{
    HXTeacherListAPI *api = [self new];
    api.subUrl = API_GET_TEACHER_LIST;
    if (limit) {
        [api.parameters setObject:limit forKey:@"limit"];
    }
    return api;
}

@end
