//
//  HXcurriculumreviewAPI.h
//  HXBudsProject
//
//  Created by n on 2017/4/27.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

//教程评论列表
@interface HXcurriculumreviewAPI : BaseAPI

+ (instancetype)getcurriculumReviewWithCurriculum_id:(NSString*)curriculum_id limit:(NSNumber *)limit;

@end
