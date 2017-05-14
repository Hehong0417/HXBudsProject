//
//  HXpurchaseCourseAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXpurchaseCourseAPI : BaseAPI
+(instancetype)purchaseCourseWithCurriculum_id:(NSString *)curriculum_id curriculum_price:(NSString *)curriculum_price;
@end
