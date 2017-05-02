//
//  HXBuyBottomView.h
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^addSubscribeBlock)();

@interface HXBuyBottomView : UIView

@property(nonatomic,strong) UIButton *consultBtn;
@property(nonatomic,strong) UIButton *buyCourseBtn;
@property(nonatomic,strong) UIViewController *vc;
@property(nonatomic,copy) addSubscribeBlock addSubscribeBlock;

@end
