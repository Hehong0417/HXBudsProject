//
//  HXIsLoginAPI.h
//  HXBudsProject
//
//  Created by n on 2017/4/28.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXIsLoginAPI : BaseAPI
+ (instancetype)isLoginWithToken:(NSString *)token;
@end
