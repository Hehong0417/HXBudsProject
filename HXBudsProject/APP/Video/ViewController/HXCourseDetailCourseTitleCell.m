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

    XYQButton *iconBtn = [XYQButton ButtonWithFrame:CGRectMake(0,0, self.starView.mj_w, self.starView.mj_h) imgaeName:@"videoIcon" titleName:@"图图老师" contentType:LeftImageRightTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kYellwColor fontsize:13] tapAction:^(XYQButton *button) {
        
    }];
    
    [self.starView addSubview:iconBtn];
}
+ (instancetype)initCourseDetailCourseTitleCellWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXCourseDetailCourseTitleCell" owner:nil options:nil]lastObject];

}

@end
