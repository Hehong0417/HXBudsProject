//
//  HXAddWatchvideosRecordAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXAddWatchvideosRecordAPI.h"

@implementation HXAddWatchvideosRecordAPI
+ (instancetype)addWatchVideoRecordWithcurriculum_id:(NSString *)curriculum_id videos_id:(NSString *)videos_id{
    
    HXAddWatchvideosRecordAPI *api = [self new];
    api.subUrl = API_watchvideos_add;
    [api.parameters setObject:curriculum_id forKey:@"curriculum_id"];
    [api.parameters setObject:videos_id forKey:@"videos_id"];
    api.parametersAddToken = YES;
    return api;
}
@end
