//
//  HXarticleSpotFabulousAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/12.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXarticleReviewAPI : BaseAPI
+(instancetype)articlereviewAddWitharticle_id:(NSString *)article_id  review_content:(NSString  *)review_content;
@end
