//
//  HXBuyBottomView.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXBuyBottomView.h"



@implementation HXBuyBottomView


- (instancetype)initWithFrame:(CGRect)frame {

    if (self == [super initWithFrame:frame]) {
//        self.frame.size.width*0.28
        self.consultBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)  target:self action:@selector(consultAction:) title:@"收藏视频" titleColor: kWhiteColor font:FONT(18) backgroundColor:APP_COMMON_COLOR];
    
        [self addSubview:self.consultBtn];
//
//       self.buyCourseBtn = [UIButton lh_buttonWithFrame:CGRectMake(SCREEN_WIDTH - self.frame.size.width*0.72, 0, self.frame.size.width*0.72, self.frame.size.height)target:self action:@selector(buyCourseAction:) title:@"购买该教程" titleColor:kWhiteColor font:FONT(18) backgroundColor: [UIColor colorWithHexString:@"#F5A623"]];
//                           
//        [self addSubview:self.buyCourseBtn];
        
        
    }

    return self;

}
- (void)consultAction:(UIButton *)btn{



}
//- (void)buyCourseAction:(UIButton *)btn{
//
//
//
//
//}


@end
