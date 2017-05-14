
//
//  HXSubjectArticleAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSubjectArticleAPI.h"

@implementation HXSubjectArticleAPI

+ (instancetype)getSubjectArticleWithArticletype_id:(NSString *)articletype_id{

    HXSubjectArticleAPI *api = [HXSubjectArticleAPI new];
    api.subUrl = API_GET_ARTICLE;
    if (articletype_id) {
        [api.parameters setObject:articletype_id forKey:@"articletype_id"];
    }
    api.parametersAddToken = NO;
    return api;


}


@end
