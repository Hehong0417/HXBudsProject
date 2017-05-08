//
//  HXHomeAPI.h
//  HXBudsProject
//
//  Created by n on 2017/4/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXTeacherListAPI : BaseAPI

+(instancetype)getTeacherListWithWithLimit:(NSNumber*)limit isLogin:(BOOL)isLogin;

@end
