//
//  HXMyArticleCell.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyArticleCell.h"

@implementation HXMyArticleCell

+ (instancetype)initMyArticleCellWithXib{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"HXMyArticleCell" owner:nil options:nil]lastObject];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(HXInfoArticleListModel *)model {

    _model = model;
    self.contentLab.text = model.article_title;
    
    self.readLab.text = [NSString stringWithFormat:@"阅读·%@",model.reading?model.reading:@"0"];
    
    self.tapLab.text = [NSString stringWithFormat:@"赞赏·%@",model.appreciate?model.appreciate:@"0"];
    
    self.commentLab.text = [NSString stringWithFormat:@"评论·%@",model.comment?model.comment:@"0"];
    [self.rightIcon sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.article_cover)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
    
}


@end
