//
//  HXSubjectArticleAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXSubjectArticleAPI : BaseAPI

+ (instancetype)getSubjectArticleWithArticletype_id:(NSString *)articletype_id;

@end
