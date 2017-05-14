//
//  HXMyMessageAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyMessageAPI.h"

@implementation HXMyMessageAPI
+(instancetype)getMyMessage{

    HXMyMessageAPI *api = [self new];
    api.subUrl = API_systemnotification;
    return api;
}

@end
