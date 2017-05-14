//
//  HXvideoCollectionCell.m
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXvideoCollectionCell.h"
#import "HXMyLikeVC.h"
#import "HXCourseDetailAnotherVC.h"
@implementation HXvideoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.videoImagV.userInteractionEnabled = YES;
    
    [self.videoIconImgV lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    
    
    self.videoIconImgV.userInteractionEnabled = YES;
    
    [self.videoIconImgV setTapActionWithBlock:^{
        
        HXMyLikeVC *vc = [HXMyLikeVC new];
        vc.titleStr = @"他的主页";
        vc.dynamicType = teacherDynamicType;
        [self.nav pushVC:vc];
    }];
    self.teacherNameLab.userInteractionEnabled = YES;

    [self.teacherNameLab setTapActionWithBlock:^{
        
        HXMyLikeVC *vc = [HXMyLikeVC new];
        vc.titleStr = @"他的主页";
        vc.dynamicType = teacherDynamicType;
        [self.nav pushVC:vc];
    }];
    self.videoTitleLab.userInteractionEnabled = YES;
    
   

}
- (void)setModel:(HXSubjectVideoModel *)model {

    _model = model;
    
    self.teacherNameLab.text = model.the_name;
    [self.videoImagV sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.curr_picture)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
    self.videoTitleLab.text = model.curr_title;
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
    self.viewsLab.text = [NSString stringWithFormat:@"%@人看过",read];
    self.commentLab.text = [NSString stringWithFormat:@"%@人评论过",comment];
    [self.videoIconImgV  sd_setImageWithURL:[NSURL URLWithString:kAPITeacherImageFromUrl(model.The_headportrait)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
    
    [self.videoImagV setTapActionWithBlock:^{
        
        HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
        vc.curriculum_id = model.curriculum_id;
        vc.playImageStr = model.curr_picture;
        vc.curriculum_price = model.curriculum_price;
        vc.charge_status_text = model.charge_status_text;
        [self.nav pushVC:vc];
    }];
    [self.videoTitleLab setTapActionWithBlock:^{
        
        HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
        vc.curriculum_id = model.curriculum_id;
        vc.playImageStr = model.curr_picture;
        vc.curriculum_price = model.curriculum_price;
        vc.charge_status_text = model.charge_status_text;
        [self.nav pushVC:vc];
        
    }];
}
@end
