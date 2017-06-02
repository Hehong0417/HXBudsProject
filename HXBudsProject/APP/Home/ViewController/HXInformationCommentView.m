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
        self.reViewTextField.centerY = 25;
        self.reViewTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.reViewTextField];
        
        //收藏按钮
        self.collectionBtn = [UIButton lh_buttonWithFrame:CGRectMake(frame.size.width-47*2, 0,47, 50) target:self action:@selector(collectionBtnAction:) image:[UIImage imageNamed:@"collect"]];
        [self.collectionBtn setImage:[UIImage imageNamed:@"collect1"] forState:UIControlStateSelected];
        [self addSubview:self.collectionBtn];
        //
        self.shareBtn = [UIButton lh_buttonWithFrame:CGRectMake(frame.size.width-47, 0,47, 50) target:self action:@selector(shareBtnAction) image:[UIImage imageNamed:@"share1"]];
        [self addSubview:self.shareBtn];
    }
    return self;
}
- (void)collectionBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.selectefinishBlock(btn.selected);

}
- (void)backAction{
   
    [self.nav popVC];
}
- (void)shareBtnAction{


}

@end
