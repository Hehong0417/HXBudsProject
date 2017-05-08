//
//  HXMyattetionTeacherAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyattetionTeacherAPI.h"

@implementation HXMyattetionTeacherAPI

+(instancetype)getMyattetionTeacher{
    
        HXMyattetionTeacherAPI *api = [HXMyattetionTeacherAPI new];
        api.subUrl = API_GET_followTheteacher;
        api.parametersAddToken = YES;
        return api;
        
}

@end
