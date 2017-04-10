//
//  HXMyHomeHeadView.h
//  HXBudsProject
//
//  Created by n on 2017/3/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXMyHomeHeadView : UIView

@property(nonatomic,strong) UINavigationController *nav;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet UIButton *messageBtn;

@property(nonatomic,assign) BOOL isMyHomeInfo;

+ (instancetype)initMyHomeHeadViewWithXib;

@end
