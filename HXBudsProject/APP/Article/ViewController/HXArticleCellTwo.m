//
//  HXArticleCellTwo.m
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXArticleCellTwo.h"
#import "HXMyLikeVC.h"
#import "HXSubjectListTVC.h"
#import "UIView+WHC_AutoLayout.h"


@implementation HXArticleCellTwo

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.teacherIconImagV.userInteractionEnabled = YES;
    [self.teacherIconImagV lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    [self setLayout];
    
    
    [self.subjectLab lh_setCornerRadius:5 borderWidth:1 borderColor:APP_COMMON_COLOR];
    self.subjectLab.userInteractionEnabled = YES;
    [self.subjectLab setTapActionWithBlock:^{
        HXSubjectListTVC *vc = [HXSubjectListTVC new];
        vc.titleStr = self.subjectLab.text;
        [self.nav pushVC:vc];
        
    }];
    [self.rightIconImgV lh_setCornerRadius:3 borderWidth:0 borderColor:nil];
    
    
}
- (void)setLayout{

    [self.teacherIconImagV whc_LeftSpace:15];
    [self.teacherIconImagV whc_TopSpace:8];
    [self.teacherIconImagV whc_Width:35];
    [self.teacherIconImagV whc_Height:35];
    
    [self.teacherNameLab whc_HeightEqualView:self.teacherIconImagV];
    [self.teacherNameLab whc_LeftSpace:10 toView:self.teacherIconImagV];
    [self.teacherNameLab whc_TopSpace:8];
    [self.teacherNameLab whc_Width:60];
    
    [self.timeLab whc_TopSpace:8];
    [self.timeLab whc_HeightEqualView:self.teacherIconImagV];
    [self.timeLab whc_LeftSpace:15 toView:self.teacherNameLab];
    [self.timeLab whc_RightSpace:10 toView:self.collectCountLab];
    
    [self.collectCountLab whc_TopSpace:8];
    [self.collectCountLab whc_HeightEqualView:self.teacherIconImagV];
    [self.collectCountLab whc_Width:72];
    [self.collectCountLab whc_RightSpace:10];
    
    [self.rightIconImgV whc_Height:67];
    [self.rightIconImgV whc_Width:67];
    [self.rightIconImgV whc_TopSpace:10 toView:self.collectCountLab];
    [self.rightIconImgV whc_RightSpace:10];
    
    [self.contentLab whc_TopSpace:10 toView:self.teacherIconImagV];
    [self.contentLab whc_LeftSpace:15];
    [self.contentLab whc_RightSpaceEqualView:self.rightIconImgV offset:67+10];
    [self.contentLab whc_AutoHeight];
    
    [self.subjectLab whc_AutoWidth];
    [self.contentLab whc_LeftSpace:15];
    [self.subjectLab whc_Height:22];
    [self.subjectLab whc_TopSpace:10 toView:self.contentLab];
    
    [self.viewsLab whc_AutoWidth];
    [self.viewsLab whc_LeftSpace:10 toView:self.subjectLab];
    [self.viewsLab whc_HeightEqualView:self.subjectLab];
    [self.viewsLab whc_TopSpaceEqualView:self.subjectLab];
    
    [self.commentCountLab whc_AutoWidth];
    [self.commentCountLab whc_LeftSpace:10 toView:self.viewsLab];
    [self.commentCountLab whc_TopSpaceEqualView:self.subjectLab];
     [self.commentCountLab whc_HeightEqualView:self.subjectLab];
    
    [self.admireCountLab whc_AutoWidth];
    [self.admireCountLab whc_LeftSpace:10 toView:self.commentCountLab];
    [self.admireCountLab whc_TopSpaceEqualView:self.subjectLab];
    [self.admireCountLab whc_HeightEqualView:self.subjectLab];
    
    [self.downLineView whc_LeftSpace:10 ];
    [self.downLineView whc_TopSpace:10 toView:self.admireCountLab];
    [self.downLineView whc_RightSpace:10];
    [self.downLineView whc_Height:1];
    
    self.whc_CellBottomOffset = 10;
    self.whc_CellBottomView = self.downLineView;

}
- (void)setArticleType:(ArticleType)articleType {
    
    _articleType = articleType;
    
    switch (self.articleType) {
        case homeArticle:{
            self.subjectLab.whc_WidthAuto();
            self.collectCountLab.hidden = NO;
            self.subjectLab.whc_LeftSpace(10);
        }
            break;
        default:{
            self.subjectLab.whc_Width(0);
            self.collectCountLab.hidden = YES;
            self.subjectLab.whc_LeftSpace(0);
            
        }
            break;
    }
}
+ (instancetype)initArticleCellTwoWithXib{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"HXArticleCellTwo" owner:self options:nil] lastObject];
    
}
- (void)setModel:(HXInfoArticleListModel *)model {

    _model = model;
    if (!model.articletype_name) {
        self.subjectLab.whc_Width(0);
        self.collectCountLab.hidden = YES;
        self.subjectLab.whc_LeftSpace(0);
    }else{
        self.subjectLab.whc_WidthAuto();
        self.collectCountLab.hidden = NO;
        self.subjectLab.whc_LeftSpace(10);
    self.subjectLab.text = [NSString stringWithFormat:@"  #%@#  ",model.articletype_name];
    }
    self.timeLab.text = model.ctime;
    
    [self.teacherIconImagV sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(@"")] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
    [self.rightIconImgV sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(@"")] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
//    self.teacherNameLab.text = ;
    self.contentLab.text = model.article_title;
    NSString *read;
    read = model.reading?model.reading:@"0";
    self.viewsLab.text = [NSString stringWithFormat:@"阅读·%@",read];
//      self.commentCountLab.text = [NSString stringWithFormat:@"评论·%@",];
//    self.admireCountLab.text = [NSString stringWithFormat:@"赞赏·%@",];
//      self.commentCountLab.text = [NSString stringWithFormat:@"收藏|%@",];
    
    [self.teacherIconImagV setTapActionWithBlock:^{
        HXMyLikeVC *vc = [HXMyLikeVC new];
        vc.dynamicType = himDynamicType;
        vc.titleStr = @"他的主页";
        vc.users_id = model.users_id;
        [self.nav pushVC:vc];
        
    }];
    self.teacherNameLab.userInteractionEnabled = YES;
    [self.teacherNameLab setTapActionWithBlock:^{
        HXMyLikeVC *vc = [HXMyLikeVC new];
        vc.dynamicType = himDynamicType;
        vc.users_id = model.users_id;
        vc.titleStr = @"他的主页";
        [self.nav pushVC:vc];
    }];

}

@end
