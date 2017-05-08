//
//  HXBroserRecordVideoAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/4.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXBroserRecordVideoAPI.h"

@implementation HXBroserRecordVideoAPI

+ (instancetype)getBroserRecordVideoData{

    HXBroserRecordVideoAPI *api = [HXBroserRecordVideoAPI new];
    api.subUrl = API_GET_browseCourse;
    api.parametersAddToken = YES;
    return api;

}
@end
