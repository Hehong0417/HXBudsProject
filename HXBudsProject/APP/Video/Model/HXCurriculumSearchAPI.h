//
//  HXCurriculumSearchAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/5.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXCurriculumSearchAPI : BaseAPI

+ (instancetype)getsearchCurriculumListWithCurr_title:(NSString *)curr_title teachingtype_id:(NSString *)teachingtype_id;

@end
