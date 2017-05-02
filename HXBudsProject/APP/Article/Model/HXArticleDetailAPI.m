//
//  HXArticleDetailAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/26.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXArticleDetailAPI.h"

@implementation HXArticleDetailAPI

+ (instancetype)getArticleDetailWithArticle_id:(NSString *)article_id{

    HXArticleDetailAPI *api = [HXArticleDetailAPI new];
    api.subUrl = API_GET_TEACHER_DDETAIL;
    
    if (article_id) {
        [api.parameters setObject:article_id forKey:@"article_id"];
    }
    
    return api;
}
@end
