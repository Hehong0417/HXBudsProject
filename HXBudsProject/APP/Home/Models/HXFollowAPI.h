//
//  HXFollowAPI.h
//  HXBudsProject
//
//  Created by n on 2017/4/26.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXFollowAPI : BaseAPI

+(instancetype)followTeacherWiththeteacherId:(NSString *)theteacher_id state:(NSString *)state;

@end
