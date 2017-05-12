//
//  HXBuyBottomView.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXBuyBottomView.h"
#import <AlipaySDK/AlipaySDK.h>



@interface HXBuyBottomView ()

@end

@implementation HXBuyBottomView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        //        self.frame.size.width*0.28
        self.consultBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)  target:self action:@selector(consultAction:) title:@"加入学习" titleColor: kWhiteColor font:FONT(18) backgroundColor:APP_COMMON_COLOR];
//        [self.consultBtn setTitle:@"加入学习" forState:UIControlStateNormal];
//        [self.consultBtn setTitle:@"已加入" forState:UIControlStateSelected];
    
        [self addSubview:self.consultBtn];
        //     self.frame.size.width*0.72
//        self.buyCourseBtn = [UIButton lh_buttonWithFrame:CGRectMake(SCREEN_WIDTH - self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height)target:self action:@selector(buyCourseAction:) title:@"赞赏" titleColor:kWhiteColor font:FONT(18) backgroundColor: RGB(255,168,37)];
//        
//        [self addSubview:self.buyCourseBtn];
        
    }
    
    return self;
    
}

- (void)consultAction:(UIButton *)btn{
    
    if (self.addSubscribeBlock) {
        self.addSubscribeBlock();
    }
    
    
}
- (void)buyCourseAction:(UIButton *)btn{
    

}

@end
