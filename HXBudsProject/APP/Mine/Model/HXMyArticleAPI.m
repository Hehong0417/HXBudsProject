//
//  HXMyArticleAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/25.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyArticleAPI.h"

@implementation HXMyArticleAPI
+(instancetype)getMyArticleData{
    HXMyArticleAPI *api = [HXMyArticleAPI new];
    api.subUrl = API_GET_ARTICLE;
    api.parametersAddToken = YES;
    return api;
}

@end
