//
//  HXHomeInfoArtcleAPI.h
//  HXBudsProject
//
//  Created by n on 2017/4/25.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

//主页文章

@interface HXHomeInfoArtcleAPI : BaseAPI

+ (instancetype)getHomeInfoArticleWithTheteacherId:(NSString *)theteacher_id mechanism_id:(NSString *)mechanism_id;
@end
