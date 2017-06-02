//
//  HXSearchVideoCell.m
//  HXBudsProject
//
//  Created by n on 2017/3/27.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSearchVideoCell.h"

@implementation HXSearchVideoCell

+(instancetype)initSearchVideoCellWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXSearchVideoCell" owner:nil options:nil] lastObject];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.the_head lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
}
- (void)setModel:(HXSubjectVideoModel *)model{

    _model = model;
    
    if ([model.mechanism_id isEqualToString:@"0"]) {
        
        [self.the_head sd_setImageWithURL:[NSURL URLWithString:kAPITeacherImageFromUrl(model.The_headportrait)] placeholderImage:[UIImage imageNamed:@"article_ico"]];
    
    }else{
       [self.the_head sd_setImageWithURL:[NSURL URLWithString:kAPImechanismFromUrl(model.The_headportrait)] placeholderImage:[UIImage imageNamed:@"article_ico"]];
    }

    [self.curri_picture sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.curr_picture)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
    self.curri_title.text = model.curr_title;
    self.the_name.text = model.the_name;
}


@end
