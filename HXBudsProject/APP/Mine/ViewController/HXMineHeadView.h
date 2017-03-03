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


@property (weak, nonatomic) IBOutlet UIImageView *icon_imgV;

@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *sexyBtn;
@property (weak, nonatomic) IBOutlet UIButton *rankBtn;

@property (weak, nonatomic) IBOutlet UILabel *attentionLab;

@property (weak, nonatomic) IBOutlet UILabel *messageLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;


+ (instancetype)initmineHeadViewWithXib;

@end
