//
//  HXArticleCellTwo.m
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXArticleCellTwo.h"
#import "HXMyLikeVC.h"
#import "HXSubjectListTVC.h"

@implementation HXArticleCellTwo

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.teacherIconImagV.userInteractionEnabled = YES;
    [self.teacherIconImagV setTapActionWithBlock:^{
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
    
    [self.subjectLab lh_setCornerRadius:5 borderWidth:1 borderColor:APP_COMMON_COLOR];
    self.subjectLab.userInteractionEnabled = YES;
    [self.subjectLab setTapActionWithBlock:^{
        HXSubjectListTVC *vc = [HXSubjectListTVC new];
        vc.titleStr = self.subjectLab.text;
        [self.nav pushVC:vc];
        
    }];
    [self.rightIconImgV lh_setCornerRadius:3 borderWidth:0 borderColor:nil];
    
    

}
+ (instancetype)initArticleCellTwoWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXArticleCellTwo" owner:self options:nil] lastObject];

}


@end
