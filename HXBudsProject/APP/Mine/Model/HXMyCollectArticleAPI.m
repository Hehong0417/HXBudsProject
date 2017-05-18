//
//  HXMyCollectArticleAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/17.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyCollectArticleAPI.h"

@implementation HXMyCollectArticleAPI

+(instancetype)getMycollectionarticle{
    
    HXMyCollectArticleAPI *api = [self new];
    api.subUrl = API_My_collectionarticle;
    return api;
}
@end
