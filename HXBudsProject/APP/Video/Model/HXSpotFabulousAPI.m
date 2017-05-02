//
//  HXSpotFabulousAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/27.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSpotFabulousAPI.h"

@implementation HXSpotFabulousAPI
+ (instancetype)addSpotFabulousWithcurriculumreview_id:(NSString *)curriculumreview_id{

    HXSpotFabulousAPI *api = [HXSpotFabulousAPI new];
    api.subUrl = API_GET_SPOTFABULOUS;
    if (curriculumreview_id) {
        [api.parameters setObject:curriculumreview_id forKey:@"curriculumreview_id"];
    }
    api.parametersAddToken = YES;
    
    return api;

}

@end
