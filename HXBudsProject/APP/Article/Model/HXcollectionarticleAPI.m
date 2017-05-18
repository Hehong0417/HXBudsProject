//
//  HXcollectionarticleAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/12.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXcollectionarticleAPI.h"

@implementation HXcollectionarticleAPI

+ (instancetype)collectionarticleWitharticle_id:(NSString *)article_id state:(NSString *)state{

    HXcollectionarticleAPI *api = [HXcollectionarticleAPI new];
    if (article_id) {
        [api.parameters setObject:article_id forKey:@"article_id"];
    }
    if (state) {
        [api.parameters setObject:state forKey:@"state"];
    }
    api.subUrl = API_collectionarticle;
    api.parametersAddToken = YES;
    
    return api;

}

@end
