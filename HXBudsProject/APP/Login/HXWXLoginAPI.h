//
//  HXWXLoginAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXWXLoginAPI : BaseAPI

+ (instancetype)WXloginWithoptionid:(NSString *)optionid headportrait:(NSString *)headportrait sex:(NSString *)sex nickname:(NSString *)nickname;

@end
