//
//  HXArticleCellTwo.h
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXHomeInfoArticleModel.h"

typedef NS_ENUM(NSUInteger, ArticleType) {
    homeArticle,
    homeInfoArticle,
};

@interface HXArticleCellTwo : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *subjectLab;
@property (weak, nonatomic) IBOutlet UIImageView *rightIconImgV;
@property (weak, nonatomic) IBOutlet UIImageView *teacherIconImagV;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLab;
@property (assign, nonatomic) ArticleType articleType;
@property (weak, nonatomic) IBOutlet UILabel *collectCountLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *viewsLab;
@property (weak, nonatomic) IBOutlet UILabel *admireCountLab;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLab;
@property (weak, nonatomic) IBOutlet UIView *downLineView;

@property (strong, nonatomic) HXInfoArticleListModel *model;

@property(nonatomic,strong) UINavigationController *nav;
+ (instancetype)initArticleCellTwoWithXib;


@end
