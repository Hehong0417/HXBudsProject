//
//  HXRegisterVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/26.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXRegisterVC.h"
#import "LHVerifyCodeButton.h"
#import "HXCommitPassWordVC.h"
#import "HXVerifyPhoneNumAPI.h"
#import "HXGetVerifyCodeAPI.h"

@interface HXRegisterVC ()<UITextFieldDelegate>
{
    UITextField *phoneNumTextFiled;
    UITextField *passWordTextFiled;
    LHVerifyCodeButton *verifyCodeBtn;
    NSString *verifyCode;

}
@end

@implementation HXRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //导航栏背景图片
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    UIColor *leftColor = RGB(0, 215, 92);
    UIColor *rightColor = RGB(0, 173, 223);
    gradientLayer.colors = @[(__bridge id)leftColor.CGColor,(__bridge id)rightColor.CGColor];
    gradientLayer.locations = @[@0.0,@0.95];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0.0, 1.0);
    gradientLayer.frame = self.view.bounds;
    
    //背景View
    UIView *bgView = [UIView lh_viewWithFrame:self.view.bounds backColor:kWhiteColor];
    
    [self.view addSubview:bgView];
    
    [bgView.layer addSublayer:gradientLayer];
    
    UIImageView *logoImageV = [UIImageView lh_imageViewWithFrame:CGRectMake(0, WidthScaleSize_H(100), WidthScaleSize_H(90), WidthScaleSize_H(90)) image:[UIImage imageNamed:@"logo"]];
    [bgView addSubview:logoImageV];
    
    [logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(WidthScaleSize_H(100));
        make.centerX.equalTo(bgView);
    }];
    
    //返回按钮
    UIButton *backBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 30, 60, 30)  target:self action:@selector(backAction:) image:[UIImage imageNamed:@"back"] title:@"" titleColor:nil font:nil];
    [bgView addSubview:backBtn];
    //textFiled
    
    //手机号码背景
    UIView *phoneNumBgView = [UIView lh_viewWithFrame:CGRectZero backColor:RGB(62, 164, 140)];
    [bgView addSubview:phoneNumBgView];
    [phoneNumBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.centerX.equalTo(bgView.mas_centerX);
        make.top.equalTo(logoImageV.mas_bottom).with.offset(WidthScaleSize_H(45));
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(WidthScaleSize_H(45));
    }];
    [phoneNumBgView lh_setCornerRadius:WidthScaleSize_H(45)/2 borderWidth:0 borderColor:nil];
    phoneNumBgView.alpha = 0.19;
    
    
    phoneNumTextFiled = [UITextField lh_textFieldWithFrame:CGRectZero placeholder:@"请输入手机号码" font:FONT(15) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    phoneNumTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    phoneNumTextFiled.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    phoneNumTextFiled.textColor = kWhiteColor;
    phoneNumTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumTextFiled.leftViewMode = UITextFieldViewModeAlways;
    UIButton *btn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 40, WidthScaleSize_H(45)) target:self action:nil image:[UIImage imageNamed:@"phoneNum"]];
    // btn.backgroundColor = kClearColor;
    phoneNumTextFiled.leftView = btn;
    [bgView addSubview:phoneNumTextFiled];
    [phoneNumTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.centerX.equalTo(bgView.mas_centerX);
        make.top.equalTo(logoImageV.mas_bottom).with.offset(WidthScaleSize_H(45));
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(WidthScaleSize_H(45));
    }];
    
    
    
    UIView *passWordBgView = [UIView lh_viewWithFrame:CGRectZero backColor:RGB(62, 164, 140)];
    [bgView addSubview:passWordBgView];
    [passWordBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.centerX.equalTo(bgView);
        make.top.equalTo(phoneNumTextFiled.mas_bottom).with.offset(WidthScaleSize_H(22));
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(WidthScaleSize_H(45));
    }];
    [passWordBgView lh_setCornerRadius:WidthScaleSize_H(45)/2 borderWidth:0 borderColor:nil];
    passWordBgView.alpha = 0.19;
    
    
    passWordTextFiled = [UITextField lh_textFieldWithFrame:CGRectZero placeholder:nil font:FONT(15) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    [bgView addSubview:passWordTextFiled];
    passWordTextFiled.textColor = kWhiteColor;
     passWordTextFiled.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    passWordTextFiled.keyboardType = UIKeyboardTypeNumberPad;

    passWordTextFiled.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 22, WidthScaleSize_H(45))];
    passWordTextFiled.leftViewMode = UITextFieldViewModeAlways;
    
    //验证码按钮
    
    UIView *codeBgView = [UIView lh_viewWithFrame:CGRectMake(SCREEN_WIDTH - 30 - WidthScaleSize_H(140), 0, WidthScaleSize_H(140), WidthScaleSize_H(45)) backColor:RGB(0, 0, 0)];
    
    [passWordTextFiled addSubview:codeBgView];

    codeBgView.alpha = 0.19;
    verifyCodeBtn = [[LHVerifyCodeButton alloc]initWithFrame:codeBgView.frame];
    verifyCodeBtn.backgroundColor = kClearColor;
    [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    verifyCodeBtn.titleLabel.font = FONT(15);
    [verifyCodeBtn addTarget:self action:@selector(getVerifyCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [codeBgView lh_setCornerRadius:WidthScaleSize_H(45)/2 borderWidth:0 borderColor:nil];
    passWordTextFiled.rightView = verifyCodeBtn;
    passWordTextFiled.rightViewMode = UITextFieldViewModeAlways;
    [passWordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.centerX.equalTo(bgView);
        make.top.equalTo(phoneNumTextFiled.mas_bottom).with.offset(WidthScaleSize_H(22));
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(WidthScaleSize_H(45));
    }];
    [passWordTextFiled lh_setCornerRadius:WidthScaleSize_H(45)/2 borderWidth:0 borderColor:nil];
    
    
    //login按钮
    UIButton *registerBtn = [UIButton lh_buttonWithFrame:CGRectZero target:self action:@selector(registerAction:) title:@"注册" titleColor:kWhiteColor font:FONT(16) backgroundColor:kClearColor];
    [bgView addSubview:registerBtn];
    
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(passWordTextFiled.mas_bottom).with.offset(WidthScaleSize_H(22));
        make.height.mas_equalTo(WidthScaleSize_H(45));
        
    }];
    [registerBtn lh_setCornerRadius:WidthScaleSize_H(45)/2 borderWidth:1 borderColor:kWhiteColor];
    
    phoneNumTextFiled.delegate = self;
}
- (void)registerAction:(UIButton *)btn{

  NSString *validStr =  [self validAllMsg];
    
    if (!validStr) {
        [self checkVerifyCode];
    }else {
        [SVProgressHUD showInfoWithStatus:validStr];
        
    }
    
}
#pragma mark- 验证信息
- (NSString *)validAllMsg{
    
    if (phoneNumTextFiled.text.length == 0) {
        
        return  @"手机号不能为空";
        
    }else if(passWordTextFiled.text.length == 0) {
        
        return  @"请填写验证码";
        
    }
    
    return nil;
    
}
#pragma mark - textfieldDelegate限制手机号为11位

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (toBeString.length > 11 && range.length!=1){
        textField.text = [toBeString substringToIndex:11];
        return NO;
    }
    
    return YES;
}
- (void)backAction:(UIButton *)btn {
    
    [self.navigationController popVC];
    
}

- (void)getVerifyCodeAction:(LHVerifyCodeButton *)btn{
    
    if (phoneNumTextFiled.text.length == 0) {
        
        [SVProgressHUD showInfoWithStatus:@"请填写手机号"];
    }else{
    
        BOOL isvalidPhone = [NSString valiMobile:phoneNumTextFiled.text];
        if (!isvalidPhone) {
            [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号"];
        }else {
        
            [self checkPhoneOnly];

        }
        
    }

}

#pragma mark-手机号唯一性验证
- (void)checkPhoneOnly
{

    [[[HXVerifyPhoneNumAPI verifyPhoneNumWithPhoneNum:phoneNumTextFiled.text] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        NSNumber *state = responseObject[@"pd"][@"state"];
        if ([state isEqual:@0]) {
            
        [self sendverifyCodeRequest];

        }else if ([state isEqual:@1]){
        
            [SVProgressHUD showInfoWithStatus:@"手机号已注册"];
        }
    }];
        
}
#pragma mark-发送验证码请求

- (void)sendverifyCodeRequest
{
    [[[HXGetVerifyCodeAPI getVerifyCodeWithPhoneNum:phoneNumTextFiled.text] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
       
        [verifyCodeBtn startTimer:60];
        
        NSString *verifyCodeStr = responseObject[@"pd"][@"smscode"];
        
        verifyCode = verifyCodeStr;
    
    }];
    
}
#pragma mark- 验证验证码

- (void)checkVerifyCode{

    if ([verifyCode isEqualToString:passWordTextFiled.text]) {
        
            HXCommitPassWordVC *vc = [HXCommitPassWordVC new];
            vc.phoneNum = phoneNumTextFiled.text;
            [self.navigationController pushVC:vc];

    }else {
    
        [SVProgressHUD showErrorWithStatus:@"验证码输入不正确"];
    }

}


@end
