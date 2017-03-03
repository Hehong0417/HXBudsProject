//
//  HXCourseHeadView.m
//  HXBudsProject
//
//  Created by n on 2017/2/20.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseHeadView.h"

@implementation HXCourseHeadView

+ (instancetype)initCourseHeadViewWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXCourseHeadView" owner:nil options:nil]lastObject];

}

- (void)awakeFromNib {

    [super awakeFromNib];
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)RGB(118,198,170).CGColor,(__bridge id)RGB(107,199,225).CGColor];
    gradientLayer.locations = @[@0.2,@0.9];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, -20, SCREEN_WIDTH, WidthScaleSize_H(112)+20); 
    [self.bgView.layer addSublayer:gradientLayer];
    [self.chooseBgView lh_setCornerRadius:3 borderWidth:1 borderColor:kWhiteColor];
    
}


@end
