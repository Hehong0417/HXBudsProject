//
//  HXCourseCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/20.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseCell.h"

@implementation HXCourseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.playBgImageV lh_setCornerRadius:5 borderWidth:0 borderColor:nil];
    
    self.playBgViewConstraint.constant = WidthScaleSize_H(200);
    
    for (NSInteger i = 0; i < 5; i++) {
        
        CGFloat img_w = (self.starView.mj_w - 40)/5;
        UIImageView *imgView = [UIImageView lh_imageViewWithFrame:CGRectMake(i*img_w, 0, img_w, self.starView.mj_h) image:[UIImage imageNamed:@"Star_pink"]];
        imgView.contentMode = UIViewContentModeCenter;
        [self.starView addSubview:imgView];
    }
    UILabel *gradeLab = [UILabel lh_labelWithFrame:CGRectMake(self.starView.mj_w-40, 0, 40, self.starView.mj_h) text:@"4.8" textColor:[UIColor colorWithHexString:@"#F090A8"] font:FONT(14) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
    [self.starView addSubview:gradeLab];
    
}

+ (instancetype)initCourseCellWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXCourseCell" owner:nil options:nil]lastObject];

}


@end
