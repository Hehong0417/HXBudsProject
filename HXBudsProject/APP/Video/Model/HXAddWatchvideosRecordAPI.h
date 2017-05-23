//
//  HXAddWatchvideosRecordAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXAddWatchvideosRecordAPI : BaseAPI
+ (instancetype)addWatchVideoRecordWithcurriculum_id:(NSString *)curriculum_id videos_id:(NSString *)videos_id;
@end
