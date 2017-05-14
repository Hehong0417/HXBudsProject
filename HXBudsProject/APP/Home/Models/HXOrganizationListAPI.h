//
//  HXOrganizationListAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXOrganizationListAPI : BaseAPI
+ (instancetype)getOrganizationListWithLimit:(NSString*)limit;
@end
