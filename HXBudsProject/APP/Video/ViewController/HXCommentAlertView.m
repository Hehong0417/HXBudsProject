//
//  HXCommentAlertView.m
//  HXBudsProject
//
//  Created by n on 2017/3/15.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCommentAlertView.h"

@implementation HXCommentAlertView

- (UIView *)alertViewContentView{
    
    CGFloat alertView_X = WidthScaleSize_W(64);
    CGFloat alertView_W = SCREEN_WIDTH - 2*WidthScaleSize_W(64);
    CGFloat alertView_H = alertView_W - 10;
   
    
    UIView *contentView = [UIView lh_viewWithFrame:CGRectMake(alertView_X, 0, alertView_W, alertView_H) backColor:kWhiteColor];

    contentView.center =  SCREEN_CENTER;
    
    //subViews
    
    UILabel *gradeLab = [UILabel lh_labelWithFrame:CGRectMake(0, 0, contentView.width, 30) text:@"极佳" textColor:kLightGrayColor font:FONT(13) textAlignment:NSTextAlignmentCenter backgroundColor:kWhiteColor];
    [contentView addSubview:gradeLab];
    //评论框
    UITextView *commentTextView = [UITextView lh_textViewWithFrame:CGRectMake(0, CGRectGetMaxY(gradeLab.frame), contentView.width, alertView_H - 65) font:FONT(13) backgroundColor:kLightGrayColor];
    [contentView addSubview:commentTextView];
    
    //提交按钮
    UIButton *commitBtn = [UIButton lh_buttonWithFrame:CGRectMake(0,alertView_H - 35 , contentView.width, 35) target:self action:@selector(commitAction:) title:@"提交" titleColor:APP_COMMON_COLOR font:FONT(14) backgroundColor:kWhiteColor];
    [contentView addSubview:commitBtn];
    
    
    return contentView;
}
- (void)commitAction:(UIButton *)btn{




}

@end
