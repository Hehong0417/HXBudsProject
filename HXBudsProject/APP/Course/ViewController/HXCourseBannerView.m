//
//  HXCourseBannerView.m
//  HXBudsProject
//
//  Created by n on 2017/2/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseBannerView.h"

@implementation HXCourseBannerView


- (IBAction)btn1:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(courseBannerBtnClickWithIndex:)]) {
        [self.delegate courseBannerBtnClickWithIndex:1];
    }
    
}

- (IBAction)btn2:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(courseBannerBtnClickWithIndex:)]) {
        [self.delegate courseBannerBtnClickWithIndex:2];
    }
    
}
- (IBAction)btn3:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(courseBannerBtnClickWithIndex:)]) {
        [self.delegate courseBannerBtnClickWithIndex:3];
    }
}
- (IBAction)btn4:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(courseBannerBtnClickWithIndex:)]) {
        [self.delegate courseBannerBtnClickWithIndex:4];
    }
}

@end
