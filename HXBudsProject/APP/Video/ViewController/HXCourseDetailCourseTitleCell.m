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

    UILabel *teacherNameLab = [UILabel lh_labelWithFrame:CGRectMake(CGRectGetMaxX(iconImgV.frame)+6, 0, self.starView.mj_w - 30 - 6, 27) text:@"图图老师" textColor:kYellwColor font:FONT(13) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
    [self.starView addSubview:iconImgV];
    [self.starView addSubview:teacherNameLab];
    self.starView.userInteractionEnabled = YES;
    [self.starView setTapActionWithBlock:^{
        HXMyLikeVC *vc = [HXMyLikeVC new];
        [self.nav pushVC:vc];
        vc.titleStr = @"他的主页";

    }];


}
+ (instancetype)initCourseDetailCourseTitleCellWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXCourseDetailCourseTitleCell" owner:nil options:nil]lastObject];

}

@end
