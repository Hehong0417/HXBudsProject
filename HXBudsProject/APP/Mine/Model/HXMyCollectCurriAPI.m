//
//  HXMyCollectCurriAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/17.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyCollectCurriAPI.h"

@implementation HXMyCollectCurriAPI
+(instancetype)getMyCollectCurriculum{

    HXMyCollectCurriAPI *api = [self new];
    api.subUrl = API_My_collectioncurriculum;
    return api;

}
@end
