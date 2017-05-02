//
//  HXArticleDetailAPI.h
//  HXBudsProject
//
//  Created by n on 2017/4/26.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXArticleDetailAPI : BaseAPI

+ (instancetype)getArticleDetailWithArticle_id:(NSString *)article_id;

@end
