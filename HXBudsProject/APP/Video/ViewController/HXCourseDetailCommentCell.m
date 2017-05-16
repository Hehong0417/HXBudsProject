//
//  HXCourseDetailCommentCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseDetailCommentCell.h"

@implementation HXCourseDetailCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.commentIco_ImagV lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
}

+ (instancetype)initCourseDetailCommentCellWithXib{

    return [[[NSBundle mainBundle] loadNibNamed:@"HXCourseDetailCommentCell" owner:nil options:nil] lastObject];

}
- (void)setModel:(HXcurriculumreviewVarListModel *)model {

    _model = model;

    NSString *urlStr;
    
    if ([model.headportrait containsString:@"http"]) {
        urlStr = model.headportrait;
    }else{
        urlStr = kAPIImageFromUrl(model.headportrait);
    }
    
    [self.commentIco_ImagV sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"article_ico"]];
    self.comment.text = model.fabulous;
    self.reViewContent.text = model.review_content;
    self.ctime.text = model.ctime;
    self.curriReView_Title.text = model.nickname;
}
@end
