//
//  HXMyArticleVC.h
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ArticleType) {
    myArticle,
    homeInfoArticle,
};

@interface HXMyArticleVC : UIViewController

@property(nonatomic,assign) ArticleType articleType;

@end
