//
//  HXOrganizationHeadView.h
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXOrganizationHeadView : UIView
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIView *individualWorksView;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIImageView *organizationIco;

@property(nonatomic,strong) UINavigationController *nav;

+ (instancetype)initOrganizationHeadViewWithXib;

@end
