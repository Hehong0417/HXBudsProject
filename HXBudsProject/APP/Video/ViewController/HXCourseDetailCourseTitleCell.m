//
//  HXCourseDetailCourseTitleCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseDetailCourseTitleCell.h"


@implementation HXCourseDetailCourseTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    UIImageView *iconImgV = [UIImageView lh_imageViewWithFrame:CGRectMake(0,0,27, self.starView.mj_h) image:[UIImage imageNamed:@"videoIcon"] userInteractionEnabled:YES];
    [iconImgV lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    UILabel *teacherNameLab = [UILabel lh_labelWithFrame:CGRectMake(CGRectGetMaxX(iconImgV.frame)+6, 0, self.starView.mj_w - 27 - 6, 27) text:@"图图老师" textColor:kBlackColor font:FONT(13) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
    [self.starView addSubview:iconImgV];
    [self.starView addSubview:teacherNameLab];
    self.starView.userInteractionEnabled = YES;
    
    [self.starView setTapActionWithBlock:^{
        
        
    }];
}
+ (instancetype)initCourseDetailCourseTitleCellWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXCourseDetailCourseTitleCell" owner:nil options:nil]lastObject];

}
- (void)setPdModel:(HXCurrilumPdModel *)pdModel {

    _pdModel = pdModel;
    self.curr_title.text = pdModel.curr_title;
    if ([pdModel.curriculum_price isEqualToString:@"0"]||(pdModel.curriculum_price.length == 0)) {
        self.curriculum_price.text = @"免费";

    }else {
        self.curriculum_price.text = [NSString stringWithFormat:@"￥%@", pdModel.curriculum_price];
    }
    for (UIView *view in self.starView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *iconImgV = (UIImageView *)view;
            if (![pdModel.mechanism_id isEqualToString:@"0"]) {
                [iconImgV sd_setImageWithURL:[NSURL URLWithString:kAPImechanismFromUrl(pdModel.mechanism_logo)] placeholderImage:[UIImage imageNamed:@"article_ico"]];
                
            }else{
            [iconImgV sd_setImageWithURL:[NSURL URLWithString:kAPITeacherImageFromUrl(pdModel.The_headportrait)] placeholderImage:[UIImage imageNamed:@"article_ico"]];
            }
        }
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *teacherNameLab = (UILabel *)view;
            if (![pdModel.mechanism_id isEqualToString:@"0"]) {
                teacherNameLab.text = pdModel.mechanism_name;
            }else{
                teacherNameLab.text = pdModel.the_name;
            }
        }
    }
    self.read.text = [NSString stringWithFormat:@"%@人看过",pdModel.read?pdModel.read:@"0"];
   

}
- (void)setCount:(NSString *)count {

    _count = count;
    
     self.when_long.text = [NSString stringWithFormat:@"共%@课时",count];

}
@end
