//
//  HXcollectionarticleAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/12.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXcollectionarticleAPI.h"

@implementation HXcollectionarticleAPI

+ (instancetype)collectionarticleWitharticle_id:(NSString *)article_id{

    HXcollectionarticleAPI *api = [HXcollectionarticleAPI new];
    if (article_id) {
        [api.parameters setObject:article_id forKey:@"article_id"];
    }
    api.subUrl = API_articlereview_add;
    api.parametersAddToken = YES;
    
    return api;

}

@end
