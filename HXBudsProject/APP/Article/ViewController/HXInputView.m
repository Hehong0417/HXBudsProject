//
//  HXInputView.m
//  HXBudsProject
//
//  Created by n on 2017/5/16.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXInputView.h"

@interface HXInputView ()<UITextViewDelegate>

@end

@implementation HXInputView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
       
        [self addSubview:self.inputView];
        
        self.sendBtn.frame = CGRectMake(SCREEN_WIDTH- 15 -60, CGRectGetMaxY(self.inputView.frame)+8, 60, 20);
        [self.sendBtn setTitle:@"发送评论" forState:UIControlStateNormal];
        [self.sendBtn setBackgroundColor:APP_COMMON_COLOR];
        [self.sendBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        self.sendBtn.titleLabel.font = FONT(12);
        [self.sendBtn lh_setCornerRadius:3 borderWidth:0 borderColor:nil];
        [self addSubview:self.sendBtn];
        //监听键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;

}
- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    
    /*
     NSDictionary *userInfo = [notification userInfo];
     CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
     NSValue *animationDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
     NSTimeInterval timeInterval = 0;
     [animationDuration getValue:&timeInterval];
     
     if ([self.delegate respondsToSelector:@selector(keyboardWillShow:keyboardHeight:animationDuration:)]) {
     [self.delegate keyboardWillShow:self keyboardHeight:keyboardFrame.size.height animationDuration:timeInterval];
     }
     */
    CGRect keyboardEndFrameWindow;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardEndFrameWindow];
    
    double keyboardTransitionDuration;
    [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&keyboardTransitionDuration];
    
    UIViewAnimationCurve keyboardTransitionAnimationCurve;
    [[notification.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&keyboardTransitionAnimationCurve];
    
    
    //  CGRect keyboardEndFrameView = [self convertRect:keyboardEndFrameWindow fromView:nil];
    // 参数 ：速度  高度，时间
    if ([self.delegate respondsToSelector:@selector(keyboardWillShow:keyboardHeight:animationDuration:animationCurve:)]) {
        
        [self.delegate keyboardWillShow:self keyboardHeight:keyboardEndFrameWindow.size.height animationDuration:keyboardTransitionDuration animationCurve:keyboardTransitionAnimationCurve];
    }
    
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    /*
     NSDictionary *userInfo = [notification userInfo];
     CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
     NSValue *animationDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
     NSTimeInterval timeInterval = 0;
     [animationDuration getValue:&timeInterval];
     if ([self.delegate respondsToSelector:@selector(keyboardWillHide:keyboardHeight:animationDuration:)]) {
     [self.delegate keyboardWillHide:self keyboardHeight:keyboardFrame.size.height animationDuration:timeInterval];
     }
     */
    CGRect keyboardEndFrameWindow;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardEndFrameWindow];
    
    double keyboardTransitionDuration;// 获取键盘的速度
    [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&keyboardTransitionDuration];
    
    UIViewAnimationCurve keyboardTransitionAnimationCurve;
    [[notification.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&keyboardTransitionAnimationCurve];
    if ([self.delegate respondsToSelector:@selector(keyboardWillHide:keyboardHeight:animationDuration:animationCurve:)]) {
        
        [self.delegate keyboardWillHide:self keyboardHeight:keyboardEndFrameWindow.size.height animationDuration:keyboardTransitionDuration animationCurve:keyboardTransitionAnimationCurve];
    }
    
}

- (UITextView *)inputView {

    if (!_inputView) {
        _inputView = [[UITextView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 60)];
    }
    return _inputView;
}
- (UIButton *)sendBtn{

    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _sendBtn;
}


@end
