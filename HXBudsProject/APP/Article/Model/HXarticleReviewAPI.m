//
//  HXarticleSpotFabulousAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/12.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXarticleReviewAPI.h"

@implementation HXarticleReviewAPI

+(instancetype)articlereviewAddWitharticle_id:(NSString *)article_id  review_content:(NSString  *)review_content{

    HXarticleReviewAPI *api = [HXarticleReviewAPI new];
    if (article_id) {
        [api.parameters setObject:article_id forKey:@"article_id"];
    }
    if (review_content) {
        [api.parameters setObject:review_content forKey:@"review_content"];
    }

    api.subUrl = API_articlereview_add;
    api.parametersAddToken = YES;

    return api;
}

@end
