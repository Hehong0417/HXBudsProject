//
//  HXHomeInfoArtcleAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/25.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXHomeInfoArtcleAPI.h"

@implementation HXHomeInfoArtcleAPI

+ (instancetype)getHomeInfoArticleWithTheteacherId:(NSString *)theteacher_id mechanism_id:(NSString *)mechanism_id limit:(NSNumber *)limit{

    HXHomeInfoArtcleAPI *api = [HXHomeInfoArtcleAPI new];
    api.subUrl = API_GET_ARTICLE;
    if (theteacher_id) {
        [api.parameters setObject:theteacher_id forKey:@"theteacher_id"];
    }
    if (mechanism_id) {
        [api.parameters setObject:mechanism_id forKey:@"mechanism_id"];
    }
    if (limit) {
        [api.parameters setObject:limit forKey:@"limit"];
    }
    api.parametersAddToken = NO;
    return api;

}

@end
