//
//  HXvideoCollectionCell.m
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXvideoCollectionCell.h"
#import "HXMyLikeVC.h"
#import "HXCourseDetailAnotherVC.h"
@implementation HXvideoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.videoImagV.userInteractionEnabled = YES;
    
    [self.videoImagV setTapActionWithBlock:^{
        
        HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
        [self.nav pushVC:vc];
    }];
    
    self.videoIconImgV.userInteractionEnabled = YES;
    
    [self.videoIconImgV setTapActionWithBlock:^{
        
        HXMyLikeVC *vc = [HXMyLikeVC new];
        vc.titleStr = @"他的主页";
        [self.nav pushVC:vc];
    }];
    self.teacherNameLab.userInteractionEnabled = YES;

    [self.teacherNameLab setTapActionWithBlock:^{
        
        HXMyLikeVC *vc = [HXMyLikeVC new];
        vc.titleStr = @"他的主页";

        [self.nav pushVC:vc];
    }];
    self.videoTitleLab.userInteractionEnabled = YES;
    
    [self.videoTitleLab setTapActionWithBlock:^{
        
        HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
        [self.nav pushVC:vc];
        
    }];


}

@end
