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
    
    NSArray *titles  = @[@"名师课程",@"专业老师"];
    
    //112 198 199
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:titles];
    segment.frame = CGRectMake(0, 0, self.chooseBgView.mj_w, self.chooseBgView.mj_h);
    [segment lh_setCornerRadius:self.chooseBgView.mj_h/2 borderWidth:1 borderColor:kWhiteColor];
    segment.tintColor = kWhiteColor ;
    segment.selectedSegmentIndex = 0;
    NSDictionary *selectedTextAttributes = @{NSFontAttributeName :FONT(14),NSForegroundColorAttributeName:RGB(112, 198,199)};
    [segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary *unselectedTextAttributes = @{NSFontAttributeName :FONT(14),NSForegroundColorAttributeName:kWhiteColor};
    [segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    [segment setBackgroundImage:[UIImage imageWithColor:kWhiteColor] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [segment setBackgroundImage:[UIImage imageWithColor:RGB(112, 198,199)] forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
    [segment addTarget:self action:@selector(segmentSelectAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.chooseBgView addSubview:segment];
    
}

- (void)segmentSelectAction:(UISegmentedControl *)segment {
    
    NSLog(@"%ld",segment.selectedSegmentIndex);
    
}
@end
