//
//  HXModifyUserInfoAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/5.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXModifyUserInfoAPI : BaseAPI

+ (instancetype)ModifyUserInfoWithNickname:(NSString *)nickname username:(NSString *)username  phone:(NSString *)phone  sex:(NSString *)sex age:(NSString *)age hobby:(NSString *)hobby;

@end
