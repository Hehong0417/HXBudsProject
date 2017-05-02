//
//  HXReViewAddAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/27.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXReViewAddAPI.h"

@implementation HXReViewAddAPI

+ (instancetype)addReViewWithcurriculum_id:(NSString *)curriculum_id review_content:(NSString *)review_content star:(NSNumber *)star{

    HXReViewAddAPI *api = [HXReViewAddAPI new];
    api.subUrl = API_GET_REVIEW_ADD;
    if (curriculum_id) {
        [api.parameters setObject:curriculum_id forKey:@"curriculum_id"];
    }
    if (review_content) {
        [api.parameters setObject:review_content forKey:@"review_content"];
    }
    if (star) {
        [api.parameters setObject:star forKey:@"star"];
    }
    api.parametersAddToken = YES;
    
    return api;
    
}

@end
