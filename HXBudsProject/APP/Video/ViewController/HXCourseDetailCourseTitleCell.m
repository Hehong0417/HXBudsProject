//
//  HXCourseDetailCourseTitleCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseDetailCourseTitleCell.h"
#import "HXMyLikeVC.h"


@implementation HXCourseDetailCourseTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    UIImageView *iconImgV = [UIImageView lh_imageViewWithFrame:CGRectMake(0,0,30, self.starView.mj_h) image:[UIImage imageNamed:@"videoIcon"] userInteractionEnabled:YES];

    UILabel *teacherNameLab = [UILabel lh_labelWithFrame:CGRectMake(CGRectGetMaxX(iconImgV.frame)+6, 0, self.starView.mj_w - 30 - 6, 27) text:@"图图老师" textColor:RGB(255, 201, 20) font:FONT(13) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
    [self.starView addSubview:iconImgV];
    [self.starView addSubview:teacherNameLab];
    self.starView.userInteractionEnabled = YES;
    [self.starView setTapActionWithBlock:^{
        HXMyLikeVC *vc = [HXMyLikeVC new];
        vc.titleStr = @"他的主页";
        vc.dynamicType = teacherDynamicType;
        [self.nav pushVC:vc];

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
            [iconImgV sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(pdModel.The_headportrait)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
        }
        if ([view isKindOfClass:[UILabel class]]) {
             UILabel *teacherNameLab = (UILabel *)view;
            teacherNameLab.text = pdModel.the_name;
        }
    }
    self.read.text = [NSString stringWithFormat:@"%@人看过",pdModel.read?pdModel.read:@"0"];
    self.when_long.text = [NSString stringWithFormat:@"时长:%@分钟",pdModel.when_long?pdModel.when_long:@"0"];

}
@end
