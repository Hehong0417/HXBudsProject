//
//  HXChoicenessCell.m
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXChoicenessCell.h"
#import "HXCourseDetailAnotherVC.h"


@implementation HXChoicenessCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.The_headportrait lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];

}
- (void)setModel:(HXSubjectVideoModel *)model {
    
    _model = model;
    
    self.the_name.text = model.the_name;
    [self.curr_picture sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.curr_picture)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
    self.curr_title.text = model.curr_title;
    NSString *read;
    NSString *comment;
    if (model.read.length == 0) {
        
        read = @"0";
        
    }else {
        read = model.read;
    }
    if (model.comment.length == 0) {
        
        comment = @"0";
    }else {
        comment = model.comment;
    }
    self.read.text = [NSString stringWithFormat:@"%@人看过",read];
    self.comment.text = [NSString stringWithFormat:@"%@人评论过",comment];
    [self.The_headportrait  sd_setImageWithURL:[NSURL URLWithString:kAPITeacherImageFromUrl(model.The_headportrait)] placeholderImage:[UIImage imageNamed:@"article_ico"]];
    
    
    [self.curr_picture setTapActionWithBlock:^{
        
        HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
        vc.curriculum_id = model.curriculum_id;
        vc.playImageStr = model.curr_picture;
        vc.curriculum_price = model.curriculum_price;
        vc.charge_status_text = model.charge_status_text;
        vc.model = model;
        [self.nav pushVC:vc];
    }];
    [self.curr_title setTapActionWithBlock:^{
        
        HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
        vc.curriculum_id = model.curriculum_id;
        vc.playImageStr = model.curr_picture;
        vc.curriculum_price = model.curriculum_price;
        vc.charge_status_text = model.charge_status_text;
        vc.model = model;
        [self.nav pushVC:vc];
        
    }];
}

@end
