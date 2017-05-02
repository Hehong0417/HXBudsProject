//
//  HXSubscribeAddAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/27.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSubscribeAddAPI.h"

@implementation HXSubscribeAddAPI

+ (instancetype)addSubscribeWithcurriculum_id:(NSString *)curriculum_id{

    HXSubscribeAddAPI *api = [HXSubscribeAddAPI new];
    api.subUrl = API_GET_SUBSCRIBE_ADD;
    if (curriculum_id) {
      [api.parameters setObject:curriculum_id forKey:@"curriculum_id"];
    }
    api.parametersAddToken = YES;
    
    return api;

}

@end
