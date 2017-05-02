//
//  HXCurriculumDetailAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/26.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCurriculumDetailAPI.h"

@implementation HXCurriculumDetailAPI

+ (instancetype)getCurriculumDetailWithWithCurriculum_id:(NSString*)curriculum_id{

    
    HXCurriculumDetailAPI *api = [HXCurriculumDetailAPI new];
    api.subUrl = API_GET_CURRICULUM_DETAIL;
    if (curriculum_id) {
        [api.parameters setObject:curriculum_id forKey:@"curriculum_id"];
    }
    return api;

}

@end
