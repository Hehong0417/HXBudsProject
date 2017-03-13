//
//  HXSearchVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/21.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSearchView.h"
#import "HXCourseOneVC.h"



@interface HXSearchView ()


@end

@implementation HXSearchView


- (instancetype)initWithFrame:(CGRect)frame {

    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = kWhiteColor;
        [self initSubView];
        
    }

        return self;

}

- (void)initSubView {

    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)RGB(118,198,170).CGColor,(__bridge id)RGB(107,199,225).CGColor];
    gradientLayer.locations = @[@0.2,@0.9];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    
    UIView *navgation = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) backColor:nil];
    
    [self addSubview:navgation];
    
    [navgation.layer addSublayer:gradientLayer];
    
    
    XYQButton *locateBtn = [XYQButton ButtonWithFrame:CGRectMake(20, 4, 44, 60) imgaeName:@"locate" titleName:@"番禺区" contentType:TopTitleBottomImage buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kWhiteColor fontsize:14] tapAction:^(XYQButton *button) {
        
    }];
    locateBtn.centerY = navgation.centerY + 10;
    [navgation addSubview:locateBtn];
    
    //搜索框
    UIImageView *search_box = [UIImageView lh_imageViewWithFrame:CGRectMake(0, 0, WidthScaleSize_W(250), 30) image:[UIImage imageNamed:@"search_box"]];
    search_box.userInteractionEnabled = YES;
    search_box.centerX = navgation.centerX+5;
    search_box.centerY = navgation.centerY + 10;
    [navgation addSubview:search_box];
    
    
    UIImageView *search_l = [UIImageView lh_imageViewWithFrame:CGRectMake(10, 0, WidthScaleSize_W(30), 30) image:[UIImage imageNamed:@"search_L"]];
    search_l.contentMode = UIViewContentModeCenter;
    [search_box addSubview:search_l];
    
    //编辑框
    _searchText = [[UITextField alloc]initWithFrame:CGRectMake(20+WidthScaleSize_W(18), 0, WidthScaleSize_W(250) - 30 - WidthScaleSize_W(18), 30)];
    _searchText.font = FONT(14);
    _searchText.textAlignment = NSTextAlignmentLeft;

    UIColor *fontNameColor = [UIColor colorWithHexString:@"#69C6B6"];
    NSAttributedString *attributePlaceholder = [[NSAttributedString alloc]initWithString:@"想学什么" attributes:@{NSForegroundColorAttributeName:fontNameColor}];
    _searchText.attributedPlaceholder = attributePlaceholder;
    [search_box addSubview:_searchText];
    _searchText.keyboardType = UIKeyboardTypeWebSearch;
    
    
    //确定按钮
    CGFloat sureBtn_x = CGRectGetMaxX(search_box.frame)+5;
    
    UIButton *sureBtn = [UIButton  lh_buttonWithFrame:CGRectMake(sureBtn_x, 0, SCREEN_WIDTH - sureBtn_x, 30) target:self action:@selector(sureAction:) title:@"取消" titleColor:[UIColor colorWithHexString:@"#2D6B6D"] font:FONT(14) backgroundColor:kClearColor];
    sureBtn.centerY = navgation.centerY + 10;
    [navgation addSubview:sureBtn];


    
}



- (void)showAnimated:(BOOL)animated {
    
    [self av_addSuperViews];
    
    if (animated) {
        self.lh_top = self.lh_bottom;
        [UIView animateWithDuration:0.3 animations:^{
            self.lh_top = self.lh_centerY;
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (void)hideAction{

        [UIView animateWithDuration:0.3 animations:^{
            self.lh_top = self.lh_bottom;
        } completion:^(BOOL finished) {
            [self av_removeSubviews];
            
        }];

}
- (void)sureAction:(UIButton *)sureBth {


     [self hideAction];

}
- (void)av_addSuperViews {
    
    [kKeyWindow addSubview:self];
    [_searchText becomeFirstResponder];

}

- (void)av_removeSubviews {

    [self removeFromSuperview];
}


@end
