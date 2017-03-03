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
    
    
    for (NSInteger i = 0; i < 5; i++) {
        
        CGFloat img_w = (self.starView.mj_w - 40)/5;
        UIImageView *imgView = [UIImageView lh_imageViewWithFrame:CGRectMake(i*img_w, 0, img_w, self.starView.mj_h) image:[UIImage imageNamed:@"Star_pink"]];
        imgView.contentMode = UIViewContentModeCenter;
        [self.starView addSubview:imgView];
    }
    UILabel *gradeLab = [UILabel lh_labelWithFrame:CGRectMake(self.starView.mj_w-40, 0, 40, self.starView.mj_h) text:@"4.8" textColor:[UIColor colorWithHexString:@"#F090A8"] font:FONT(14) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
    [self.starView addSubview:gradeLab];
}
+ (instancetype)initCourseDetailCourseTitleCellWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXCourseDetailCourseTitleCell" owner:nil options:nil]lastObject];

}

@end
