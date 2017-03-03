//
//  HXOrganizationHeadView.m
//  HXBudsProject
//
//  Created by n on 2017/2/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationHeadView.h"

@implementation HXOrganizationHeadView

//118,198,170    107,199,225
+ (instancetype)initOrganizationHeadViewWithXib{

    return [[[NSBundle mainBundle] loadNibNamed:@"HXOrganizationHeadView" owner:nil options:nil] lastObject];
    
}
- (void)awakeFromNib{

    [super awakeFromNib];


    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)RGB(118,198,170).CGColor,(__bridge id)RGB(107,199,225).CGColor];
    gradientLayer.locations = @[@0.2,@0.9];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(150));
    [self.bgView.layer addSublayer:gradientLayer];
    
    
    self.iconImgV.image = [UIImage imageNamed:@"testIcon"];
    [self.iconImgV lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    self.organizationTitleLab.text = @"H钢琴俱乐部";
    self.categoryLab.text = @"类别：音乐培训";
    self.gradeLab.text = @"评分：";
    self.gradeDetailLab.text = @"教学 8.5 环境 9 服务 8";
    
    self.dataArr = @[@"1",@"2",@"3",@"4",@"5"];
    
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        
        UIImageView *star = [UIImageView lh_imageViewWithFrame:CGRectMake(36+i*12, CGRectGetMinY(self.gradeLab.frame), 12, 13) image:[UIImage imageNamed:@"Star_blue"]];
        [self.baseView addSubview:star];
        star.contentMode = UIViewContentModeCenter;
    }

    
}



@end
