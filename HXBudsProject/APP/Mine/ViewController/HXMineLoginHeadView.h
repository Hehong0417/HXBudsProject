//
//  HXMineLoginHeadView.h
//  HXBudsProject
//
//  Created by n on 2017/3/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTeacherDetailModel.h"

@interface HXMineLoginHeadView : UIView

@property(nonatomic,strong) UINavigationController *nav;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImagV;


+ (instancetype)initMineLoginHeadViewWithXib;

@end
