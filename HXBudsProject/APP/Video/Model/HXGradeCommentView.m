//
//  HXGradeCommentView.m
//  HXBudsProject
//
//  Created by n on 2017/4/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXGradeCommentView.h"
#import "HCSStarRatingView.h"


@interface HXGradeCommentView ()<UITextViewDelegate>{
    
    UITextView *commentTextView;
    CGFloat value;
}

@end

@implementation HXGradeCommentView

- (UIView *)alertViewContentView {
    
    UIView *commentBgView = [UIView lh_viewWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 160, WidthScaleSize_H(185)) backColor:kWhiteColor];
//    [commentBgView lh_setCornerRadius:5 borderWidth:1 borderColor:kBlackColor];
    //Star
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(40, WidthScaleSize_H(8), SCREEN_WIDTH - 160 - 80, WidthScaleSize_H(20))];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 1;
    starRatingView.value = 1.0f;
    starRatingView.tintColor = APP_COMMON_COLOR;
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [commentBgView addSubview:starRatingView];
    
    UILabel *recommend = [UILabel lh_labelWithFrame:CGRectMake(0, CGRectGetMaxY(starRatingView.frame)+5, SCREEN_WIDTH - 160, WidthScaleSize_H(30)) text:@"推荐" textColor:FontLightGrayColor font:FONT(13) textAlignment:NSTextAlignmentCenter backgroundColor:kWhiteColor];
    [commentBgView addSubview:recommend];
    
    //评论框
    commentTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(recommend.frame), SCREEN_WIDTH - 160, WidthScaleSize_H(85))];
    commentTextView.delegate = self;
    
    commentTextView.font = FONT(12);
    commentTextView.backgroundColor = KVCBackGroundColor;
//    commentTextView.placeholder = @"评论，100字内";
    [commentBgView addSubview:commentTextView];
    
    
    //提交按钮
    UIButton *commitBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, CGRectGetMaxY(commentTextView.frame), SCREEN_WIDTH - 160, WidthScaleSize_H(35)) target:self action:@selector(commitAction) title:@"提 交" titleColor:APP_COMMON_COLOR font:FONT(13) backgroundColor:kWhiteColor];
    
    [commentBgView addSubview:commitBtn];
    
    
    [commentBgView lh_setCornerRadius:5 borderWidth:0 borderColor:kBlackColor];
    
    return commentBgView;
}
- (void)didChangeValue:(HCSStarRatingView *)sender {
    
    NSLog(@"Changed rating to %.1f", sender.value);
    value = sender.value;
}
- (void)commitAction {
    //评论
    if(self.addReviewBlock){
    
        self.addReviewBlock(commentTextView.text, [NSNumber numberWithFloat:value]);
    }
    [self hideWithCompletion:nil];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [self contentViewUpperShift:YES];

}

@end
