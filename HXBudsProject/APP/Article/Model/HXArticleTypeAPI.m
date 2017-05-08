//
//  HXArticleAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXArticleTypeAPI.h"

@implementation HXArticleTypeAPI

+ (instancetype)getArticleTypeList{

    HXArticleTypeAPI *api = [HXArticleTypeAPI new];
    
    api.subUrl = API_GET_ARTICLE_TYPE;
    api.parametersAddToken = NO;

    return api;
}

@end
