//
//  HXMyAssetAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyAssetAPI.h"

@implementation HXMyAssetAPI

+ (instancetype)getMyAsset{

    HXMyAssetAPI *api = [HXMyAssetAPI new];
    api.subUrl = API_GET_myAsset;
    api.parametersAddToken = YES;
    return api;

}

@end
