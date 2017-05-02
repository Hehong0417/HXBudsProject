//
//  HXCurriculumDetailAPI.h
//  HXBudsProject
//
//  Created by n on 2017/4/26.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

//教程详情简介
@interface HXCurriculumDetailAPI : BaseAPI

+ (instancetype)getCurriculumDetailWithWithCurriculum_id:(NSString*)curriculum_id;

@end
