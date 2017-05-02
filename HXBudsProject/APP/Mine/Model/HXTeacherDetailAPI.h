//
//  HXTeacherDetailAPI.h
//  HXBudsProject
//
//  Created by n on 2017/4/25.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXTeacherDetailAPI : BaseAPI

+ (instancetype)getTeacherDetailWithTeacherId:(NSString *)teacherId users_id:(NSString *)users_id;

@end
