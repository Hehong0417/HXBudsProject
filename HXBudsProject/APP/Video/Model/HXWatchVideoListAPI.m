//
//  HXWatchVideoListAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXWatchVideoListAPI.h"

@implementation HXWatchVideoListAPI
+ (instancetype)WatchVideoRecordWithcurriculum_id:(NSString *)curriculum_id{

    HXWatchVideoListAPI *api = [self new];
    
    api.subUrl = API_watchvideos_list;
    [api.parameters setObject:curriculum_id forKey:@"curriculum_id"];
    api.parametersAddToken = YES;
    return api;


}
@end
