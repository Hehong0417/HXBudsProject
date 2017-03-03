//
//  HXTeacherBannerView.m
//  HXBudsProject
//
//  Created by n on 2017/2/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXTeacherBannerView.h"

@implementation HXTeacherBannerView

+ (instancetype)initTeacherBannerViewWithXib{

    return  [[[NSBundle mainBundle] loadNibNamed:@"HXTeacherBannerView" owner:nil options:nil] lastObject];

}

- (IBAction)teacherPrefectureAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(buttonClickWithIndex:)]) {
        [self.delegate buttonClickWithIndex:1];
    }
    
    
}
- (IBAction)subjectTeacherAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(buttonClickWithIndex:)]) {
        [self.delegate buttonClickWithIndex:2];
    }
    
}



@end
