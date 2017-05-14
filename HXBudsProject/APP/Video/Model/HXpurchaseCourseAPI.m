//
//  HXpurchaseCourseAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXpurchaseCourseAPI.h"

@implementation HXpurchaseCourseAPI

+(instancetype)purchaseCourseWithCurriculum_id:(NSString *)curriculum_id curriculum_price:(NSString *)curriculum_price{
    
    HXpurchaseCourseAPI *api = [HXpurchaseCourseAPI new];
    api.subUrl = API_purchaseCourse_add;
    if (curriculum_id) {
        [api.parameters setObject:curriculum_id forKey:@"curriculum_id"];
    }
    if (curriculum_price) {
        [api.parameters setObject:curriculum_price forKey:@"curriculum_price"];
    }
    api.parametersAddToken = YES;
    
    return api;
    
}
@end
