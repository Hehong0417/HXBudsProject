//
//  HXInputView.h
//  HXBudsProject
//
//  Created by n on 2017/5/16.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXInputView;

@protocol InputViewDelegate <NSObject>

- (void)keyboardWillShow:(HXInputView *)inputView keyboardHeight:(CGFloat)keyboardHeight animationDuration:(NSTimeInterval)duration animationCurve:(UIViewAnimationCurve)animationCurve;

- (void)keyboardWillHide:(HXInputView *)inputView keyboardHeight:(CGFloat)keyboardHeight animationDuration:(NSTimeInterval)duration animationCurve:(UIViewAnimationCurve)animationCurve;

@end

@interface HXInputView : UIView

@property(nonatomic,strong)UITextView *inputView;
@property(nonatomic,strong)UIButton *sendBtn;
@property (weak, nonatomic) id<InputViewDelegate> delegate;

@end
