//
//  HXcurriculumreviewAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/27.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXcurriculumreviewAPI.h"

@implementation HXcurriculumreviewAPI
+ (instancetype)getcurriculumReviewWithCurriculum_id:(NSString*)curriculum_id limit:(NSNumber *)limit{

    HXcurriculumreviewAPI *api = [HXcurriculumreviewAPI new];
    api.subUrl = API_GET_REVIEW_LIST;
    if (curriculum_id) {
        [api.parameters setObject:curriculum_id forKey:@"curriculum_id"];
    }
    if (limit) {
        [api.parameters setObject:limit forKey:@"limit"];
    }
    return api;




}
@end
