//
//  HXappreciationAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/12.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXappreciationAPI.h"

@implementation HXappreciationAPI

+(instancetype)appreciationarticleWitharticle_id:(NSString *)article_id app_money:(NSString *)app_money{


    HXappreciationAPI *api = [HXappreciationAPI new];
    if (article_id) {
        [api.parameters setObject:article_id forKey:@"article_id"];
    }
    if (app_money) {
        [api.parameters setObject:article_id forKey:@"app_money"];
    }
    api.subUrl = API_appreciation_add;
    api.parametersAddToken = YES;
    
    return api;


}
@end
