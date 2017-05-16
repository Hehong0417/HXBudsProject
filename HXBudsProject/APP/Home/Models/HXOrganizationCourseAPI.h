//
//  HXOrganizationCourseAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/16.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXOrganizationCourseAPI : BaseAPI
+(instancetype)getOrganizationVideoWithmechanism_id:(NSString *)mechanism_id Limit:(NSNumber *)limit;
@end
