//
//  HXappreciationAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/12.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXappreciationAPI : BaseAPI

+(instancetype)appreciationarticleWitharticle_id:(NSString *)article_id app_money:(NSString *)app_money;

@end
