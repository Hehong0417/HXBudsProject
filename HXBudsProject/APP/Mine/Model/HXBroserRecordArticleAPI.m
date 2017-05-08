//
//  HXBroserRecordArticleAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/4.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXBroserRecordArticleAPI.h"

@implementation HXBroserRecordArticleAPI

+ (instancetype)getBroserRecordArticleData{

    
    HXBroserRecordArticleAPI *api = [HXBroserRecordArticleAPI new];
    api.subUrl = API_GET_browseArticle;
    api.parametersAddToken = YES;
    return api;


}

@end
