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
//    self.readLab.text = [NSString stringWithFormat:@"阅读·%@",];
//    self.tapLab.text = [NSString stringWithFormat:@"赞赏·%@",];
//    self.commentLab.text = [NSString stringWithFormat:@"评论·%@",];
//    [self.rightIcon sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(<#url#>)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
    
}


@end
