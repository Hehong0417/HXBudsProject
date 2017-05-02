//
//  HXSubjectVideoAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/25.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSubjectVideoAPI.h"

@implementation HXSubjectVideoAPI
+(instancetype)getSubjectVideoWithLimit:(NSNumber *)limit theteacherId:(NSString *)theteacher_id{

    HXSubjectVideoAPI *api = [HXSubjectVideoAPI new];
    api.subUrl = API_GET_CURRICULUM;
    if (limit) {
        [api.parameters setObject:limit forKey:@"limit"];
    }
    if (theteacher_id) {
        [api.parameters setObject:theteacher_id forKey:@"theteacher_id"];
    }
    return api;
}
@end
