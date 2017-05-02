//
//  HXReViewAddAPI.h
//  HXBudsProject
//
//  Created by n on 2017/4/27.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXReViewAddAPI : BaseAPI

+ (instancetype)addReViewWithcurriculum_id:(NSString *)curriculum_id review_content:(NSString *)review_content star:(NSNumber *)star;

@end
