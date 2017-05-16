//
//  HXFollowOrganizationAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/16.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXFollowOrganizationAPI : BaseAPI
+(instancetype)followMechanismWithMechanism_id:(NSString *)mechanism_id state:(NSString *)state;

@end
