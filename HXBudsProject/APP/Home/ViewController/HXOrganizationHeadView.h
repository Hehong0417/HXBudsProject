//
//  HXOrganizationHeadView.h
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTeacherDetailModel.h"
#import "HXOrganizationDeetailModel.h"


@interface HXOrganizationHeadView : UIView
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
//@property (weak, nonatomic) IBOutlet UIView *individualWorksView;
@property (weak, nonatomic) IBOutlet UIView *addressView;
//机构、名师头像
@property (weak, nonatomic) IBOutlet UIImageView *organizationIco;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *introduce;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@property(nonatomic,strong) UINavigationController *nav;

+ (instancetype)initOrganizationHeadViewWithXib;
@property(nonatomic,strong) HXPdModel *pdModel;

@property(nonatomic,strong) HXOrganizationPdModel *model;

@end
