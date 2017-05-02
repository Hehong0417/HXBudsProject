//
//  HXVideoCatalogueAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/26.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXVideoCatalogueAPI.h"

@implementation HXVideoCatalogueAPI

+ (instancetype)getVideoCatalogueWithWithCurriculum_id:(NSString*)curriculum_id{
    
    HXVideoCatalogueAPI *api = [HXVideoCatalogueAPI new];
    api.subUrl = API_GET_VIDEO_LIST;
    if (curriculum_id) {
        [api.parameters setObject:curriculum_id forKey:@"curriculum_id"];
    }
    return api;
    
}
@end
