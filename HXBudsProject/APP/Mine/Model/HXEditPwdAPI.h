//
//  HXEditPwdAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/11.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXEditPwdAPI : BaseAPI
+ (instancetype)editPwdWithOldpassword:(NSString *)oldpassword NewPwd:(NSString *)password;
@end
