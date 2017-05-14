//
//  HXInformationCommentView.m
//  HXBudsProject
//
//  Created by n on 2017/3/7.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXInformationCommentView.h"

@implementation HXInformationCommentView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 45, 50) target:self action:@selector(backAction) image:[UIImage imageNamed:@"back_gray"]];
        [self addSubview:self.backBtn];
        
        //
        self.reViewTextField = [UITextField lh_textFieldWithFrame:CGRectMake(CGRectGetMaxX(self.backBtn.frame)+10, 5, frame.size.width - 2*47-self.backBtn.frame.size.width - 10, 35) placeholder:@"单行输入"  font:FONT(14) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
        self.reViewTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.reViewTextField];
        
        //
        self.collectionBtn = [UIButton lh_buttonWithFrame:CGRectMake(frame.size.width-47*2, 0,47, 50) target:self action:@selector(collectionBtnAction:) image:[UIImage imageNamed:@"collect"]];
        [self addSubview:self.collectionBtn];
        //
        self.shareBtn = [UIButton lh_buttonWithFrame:CGRectMake(frame.size.width-47, 0,47, 50) target:self action:@selector(shareBtnAction) image:[UIImage imageNamed:@"share"]];
        [self addSubview:self.shareBtn];
        //
        self.sendBtn = [UIButton lh_buttonWithFrame:CGRectMake(frame.size.width-70, CGRectGetMaxY(self.collectionBtn.frame)+5,60, 30) target:self action:@selector(sendAction) image:nil title:@"发送评论" titleColor:kWhiteColor font:FONT(12)];
        [self addSubview:self.sendBtn];
    }
    return self;
}
- (void)collectionBtnAction:(UIButton *)btn{
   

}
- (void)backAction{


}
- (void)shareBtnAction{


}
- (void)sendAction {



}
@end
