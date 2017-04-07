//
//  HXGradeCommentView.m
//  HXBudsProject
//
//  Created by n on 2017/4/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXGradeCommentView.h"
#import "HCSStarRatingView.h"

@implementation HXGradeCommentView

- (UIView *)alertViewContentView {
    
    UIView *commentBgView = [UIView lh_viewWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 160, 150) backColor:kWhiteColor];
    //Star
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(40, 10, SCREEN_WIDTH - 160 - 80, 20)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 1;
    starRatingView.value = 1.0f;
    starRatingView.tintColor = APP_COMMON_COLOR;
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [commentBgView addSubview:starRatingView];
    
    UILabel *recommend = [UILabel lh_labelWithFrame:CGRectMake(0, CGRectGetMaxY(starRatingView.frame), SCREEN_WIDTH - 160, 20) text:@"推荐" textColor:KVCBackGroundColor font:FONT(13) textAlignment:NSTextAlignmentCenter backgroundColor:kWhiteColor];
    [commentBgView addSubview:recommend];
    
    //评论框
    UITextView *commentTextView = [UITextView lh_textViewWithFrame:CGRectMake(0, CGRectGetMaxY(recommend.frame), SCREEN_WIDTH - 160, 80) font:FONT(12) backgroundColor:KVCBackGroundColor];
    [commentBgView addSubview:commentTextView];
    //提交按钮
    UIButton *commitBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, CGRectGetMaxY(commentTextView.frame), SCREEN_WIDTH - 160, 50) target:self action:@selector(commitAction) title:@"提交" titleColor:APP_COMMON_COLOR font:FONT(13) backgroundColor:kWhiteColor];
    [commentBgView addSubview:commitBtn];
    
    
//    [commentBgView lh_setCornerRadius:5 borderWidth:0 borderColor:nil];
    
    return commentBgView;
}
- (void)didChangeValue:(HCSStarRatingView *)sender {
    
    NSLog(@"Changed rating to %.1f", sender.value);
}
- (void)commitAction {




}
@end
