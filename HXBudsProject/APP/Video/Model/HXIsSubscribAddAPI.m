//
//  HXIsSubscribAddAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/4.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXIsSubscribAddAPI.h"

@implementation HXIsSubscribAddAPI

+ (instancetype)IsSubscribWithcurriculum_id:(NSString *)curriculum_id{

    HXIsSubscribAddAPI *api = [HXIsSubscribAddAPI new];
    api.subUrl = API_collectioncurriculum_isAdd;
    if (curriculum_id) {
        [api.parameters setObject:curriculum_id forKey:@"curriculum_id"];
    }
    api.parametersAddToken = YES;
    
    return api;

}
@end
