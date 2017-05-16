//
//  HXOrganizationListAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXOrganizationListAPI : BaseAPI
+ (instancetype)getOrganizationListWithmechanism_id:(NSString *)mechanism_id Limit:(NSString*)limit;
@end
