//
//  HXCurriculumSearchAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/5.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCurriculumSearchAPI.h"

@implementation HXCurriculumSearchAPI
+ (instancetype)getsearchCurriculumListWithCurr_title:(NSString *)curr_title teachingtype_id:(NSString *)teachingtype_id{

    
    HXCurriculumSearchAPI *api = [HXCurriculumSearchAPI new];
    api.subUrl = API_GET_CURRICULUM;
    if (curr_title) {
        [api.parameters setObject:curr_title forKey:@"curr_title"];
    }
    if (teachingtype_id) {
        [api.parameters setObject:teachingtype_id forKey:@"teachingtype_id"];
    }
    api.parametersAddToken = NO;
    
    return api;


}
@end
