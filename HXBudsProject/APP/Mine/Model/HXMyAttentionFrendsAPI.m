//
//  HXMyAttentionFrendsAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyAttentionFrendsAPI.h"

@implementation HXMyAttentionFrendsAPI

+ (instancetype)getMyAttentionFrends{

    HXMyAttentionFrendsAPI *api = [HXMyAttentionFrendsAPI new];
    api.subUrl = API_GET_followUsers;
    api.parametersAddToken = YES;
    return api;

}
@end
