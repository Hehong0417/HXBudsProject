//
//  HXMineHeadView.h
//  HXBudsProject
//
//  Created by n on 2017/3/2.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXMineHeadView : UIView

@property(nonatomic,strong) UINavigationController *nav;


@property (weak, nonatomic) IBOutlet UILabel *accountLab;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *loginBtnView;
@property (weak, nonatomic) IBOutlet UIView *registerBtnView;


+ (instancetype)initmineHeadViewWithXib;

@end
