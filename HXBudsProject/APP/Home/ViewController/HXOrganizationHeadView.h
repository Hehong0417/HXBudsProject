//
//  HXOrganizationHeadView.h
//  HXBudsProject
//
//  Created by n on 2017/2/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXOrganizationHeadView : UIView


@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *organizationTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *categoryLab;
@property (weak, nonatomic) IBOutlet UILabel *gradeLab;
@property (weak, nonatomic) IBOutlet UILabel *gradeDetailLab;
@property (weak, nonatomic) IBOutlet UILabel *studyCount;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLab;
@property (weak, nonatomic) IBOutlet UILabel *viewsCountLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *baseView;

@property(nonatomic,strong) NSArray *dataArr;

+ (instancetype)initOrganizationHeadViewWithXib;

@end
