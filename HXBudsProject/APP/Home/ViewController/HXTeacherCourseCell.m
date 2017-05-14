//
//  HXTeacherCourseCell.m
//  HXBudsProject
//
//  Created by n on 2017/5/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXTeacherCourseCell.h"

@implementation HXTeacherCourseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(HXSubjectVideoModel *)model {
    
    _model = model;
    [self.curr_Picture sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.curr_picture)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
    self.currimTitle.text = model.curr_title;
    self.comment.text = [NSString stringWithFormat:@"%@人评论过",model.comment?model.comment:@"0"];
    self.read.text = [NSString stringWithFormat:@"%@人看过",model.read?model.read:@"0"];
}
@end
