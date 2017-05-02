//
//  HXSubjectVideoAPI.h
//  HXBudsProject
//
//  Created by n on 2017/4/25.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXSubjectVideoAPI : BaseAPI
+(instancetype)getSubjectVideoWithLimit:(NSNumber *)limit theteacherId:(NSString *)theteacher_id;
@end
