//
//  HXHomeInfoArticleModel.h
//  HXBudsProject
//
//  Created by n on 2017/4/25.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"


@interface HXHomeInfoArticleModel : BaseModel

@property(nonatomic,strong) NSArray *varList;

@end
@interface HXInfoArticleListModel : BaseModel

@property(nonatomic,strong) NSString *article_content;
@property(nonatomic,strong) NSString *article_id;
@property(nonatomic,strong) NSString *article_title;
@property(nonatomic,strong) NSString *articletype_name;
@property(nonatomic,strong) NSString *ctime;
@property(nonatomic,strong) NSString *comment;
@property(nonatomic,strong) NSString *reading;
@property(nonatomic,strong) NSString *users_id;
@property(nonatomic,strong) NSString *The_headportrait;
@property(nonatomic,strong) NSString *article_cover;
@property(nonatomic,strong) NSString *appreciate;
@property(nonatomic,strong) NSString *The_name;
@property(nonatomic,strong) NSString *areward;


@end
