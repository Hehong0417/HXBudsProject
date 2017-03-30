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

@interface HXRegisterVC ()

@end

@implementation HXRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    //导航栏背景图片
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    UIColor *leftColor = [UIColor colorWithHexString:@"#00D75C"];
    UIColor *rightColor = [UIColor colorWithHexString:@"#00ADDF"];
    gradientLayer.colors = @[(__bridge id)leftColor.CGColor,(__bridge id)rightColor.CGColor];
    gradientLayer.locations = @[@0.0,@0.95];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0.0, 1.0);
    gradientLayer.frame = self.view.bounds;
    
    
 

    
    //背景View
    UIView *bgView = [UIView lh_viewWithFrame:self.view.bounds backColor:kWhiteColor];
    
    [self.view addSubview:bgView];
    
    [bgView.layer addSublayer:gradientLayer];
    
    UIImageView *logoImageV = [UIImageView lh_imageViewWithFrame:CGRectMake(0, 100, 90, 90) image:[UIImage imageNamed:@"logo"]];
    [bgView addSubview:logoImageV];
    
    [logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(100);
        make.centerX.equalTo(bgView);
    }];
    
    //返回按钮
    UIButton *backBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 30, 60, 30)  target:self action:@selector(backAction:) image:[UIImage imageNamed:@"back"] title:@"" titleColor:nil font:nil];
    [bgView addSubview:backBtn];
    //textFiled
    
    //手机号码背景
    UIView *phoneNumBgView = [UIView lh_viewWithFrame:CGRectZero backColor:[UIColor colorWithHexString:@"#3EA48C"]];
    [bgView addSubview:phoneNumBgView];
    [phoneNumBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.centerX.equalTo(bgView.mas_centerX);
        make.top.equalTo(logoImageV.mas_bottom).with.offset(45);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
    }];
    [phoneNumBgView lh_setCornerRadius:45/2 borderWidth:0 borderColor:nil];
    phoneNumBgView.alpha = 0.19;
    
    
    UITextField *phoneNumTextFiled = [UITextField lh_textFieldWithFrame:CGRectZero placeholder:@"请输入手机号码" font:FONT(15) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    phoneNumTextFiled.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    phoneNumTextFiled.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 22, 45)];
    phoneNumTextFiled.leftViewMode = UITextFieldViewModeAlways;
    phoneNumTextFiled.rightViewMode = UITextFieldViewModeAlways;
    UIButton *btn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 40, 45) target:self action:nil image:[UIImage imageNamed:@"phoneNum"]];
    // btn.backgroundColor = kClearColor;
    phoneNumTextFiled.rightView = btn;
    [bgView addSubview:phoneNumTextFiled];
    [phoneNumTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.centerX.equalTo(bgView.mas_centerX);
        make.top.equalTo(logoImageV.mas_bottom).with.offset(45);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
    }];
    
    
    
    UIView *passWordBgView = [UIView lh_viewWithFrame:CGRectZero backColor:[UIColor colorWithHexString:@"#3EA48C"]];
    [bgView addSubview:passWordBgView];
    [passWordBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.centerX.equalTo(bgView);
        make.top.equalTo(phoneNumTextFiled.mas_bottom).with.offset(22);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
    }];
    [passWordBgView lh_setCornerRadius:45/2 borderWidth:0 borderColor:nil];
    passWordBgView.alpha = 0.19;
    
    
    UITextField *passWordTextFiled = [UITextField lh_textFieldWithFrame:CGRectZero placeholder:nil font:FONT(15) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    [bgView addSubview:passWordTextFiled];
     passWordTextFiled.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    passWordTextFiled.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 22, 45)];
    passWordTextFiled.leftViewMode = UITextFieldViewModeAlways;
    
    //验证码按钮
    
    UIView *codeBgView = [UIView lh_viewWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 140, 0, 140, 45) backColor:[UIColor colorWithHexString:@"#000000"]];
    
    [passWordTextFiled addSubview:codeBgView];

    codeBgView.alpha = 0.19;
    LHVerifyCodeButton *verifyCodeBtn = [[LHVerifyCodeButton alloc]initWithFrame:codeBgView.frame];
    verifyCodeBtn.backgroundColor = kClearColor;
    [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    verifyCodeBtn.titleLabel.font = FONT(15);
    [verifyCodeBtn addTarget:self action:@selector(getVerifyCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [codeBgView lh_setCornerRadius:45/2 borderWidth:0 borderColor:nil];
    passWordTextFiled.rightView = verifyCodeBtn;
    passWordTextFiled.rightViewMode = UITextFieldViewModeAlways;
    [passWordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.centerX.equalTo(bgView);
        make.top.equalTo(phoneNumTextFiled.mas_bottom).with.offset(22);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
    }];
    [passWordTextFiled lh_setCornerRadius:45/2 borderWidth:0 borderColor:nil];
    
    
    //login按钮
    UIButton *registerBtn = [UIButton lh_buttonWithFrame:CGRectZero target:self action:@selector(registerAction:) title:@"注册" titleColor:kWhiteColor font:FONT(16) backgroundColor:kClearColor];
    [bgView addSubview:registerBtn];
    
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(passWordTextFiled.mas_bottom).with.offset(22);
        make.height.mas_equalTo(45);
        
    }];
    [registerBtn lh_setCornerRadius:45/2 borderWidth:1 borderColor:kWhiteColor];
    

}
- (void)registerAction:(UIButton *)btn{

    HXCommitPassWordVC *vc = [HXCommitPassWordVC new];
    [self.navigationController pushVC:vc];


}
- (void)backAction:(UIButton *)btn {
    
    [self.navigationController popVC];
    
}

- (void)getVerifyCodeAction:(LHVerifyCodeButton *)btn{

    [btn  startTimer:60];

}
@end
