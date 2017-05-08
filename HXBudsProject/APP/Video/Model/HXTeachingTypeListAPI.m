
//
//  HXTeachingTypeListAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/5.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXTeachingTypeListAPI.h"

@implementation HXTeachingTypeListAPI

+ (instancetype)getTeachingTypeList{

    HXTeachingTypeListAPI *api = [HXTeachingTypeListAPI new];
    api.subUrl = API_GET_teachingtype;
    api.parametersAddToken = NO;
    
    return api;

}



@end
