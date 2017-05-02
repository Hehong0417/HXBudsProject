//
//  HXMyArticleVC.h
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXHomeInfoArticleModel.h"

typedef NS_ENUM(NSUInteger, ArticleType) {
    mineArticle,//我的文章
    mineDynamicArticle,//我动态的文章
    teacherDynamicArticle,//老师动态文章
    himDynamicArticle //其他用户动态的文章
};

@interface HXMyArticleVC : UIViewController

@property(nonatomic,assign) ArticleType articleType;
@property(nonatomic,copy) NSString *theteacher_id;
@property(nonatomic,strong) HXHomeInfoArticleModel *infoArticleListModel;


@end
