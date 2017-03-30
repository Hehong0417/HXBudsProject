//
//  HXLoginVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/26.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXLoginVC.h"
#import "HXRegisterVC.h"
#import "HJTabBarController.h"

@interface HXLoginVC ()

@end

@implementation HXLoginVC

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
    phoneNumBgView.alpha = 0.15;
    
   
    UITextField *phoneNumTextFiled = [UITextField lh_textFieldWithFrame:CGRectZero placeholder:nil font:FONT(15) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
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
    passWordBgView.alpha = 0.15;
    
    
    UITextField *passWordTextFiled = [UITextField lh_textFieldWithFrame:CGRectZero placeholder:nil font:FONT(15) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    [bgView addSubview:passWordTextFiled];
    passWordTextFiled.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    passWordTextFiled.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 22, 45)];
    passWordTextFiled.leftViewMode = UITextFieldViewModeAlways;
    passWordTextFiled.rightView = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 40, 45) target:self action:nil image:[UIImage imageNamed:@"passWord"]];
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
   UIButton *loginBtn = [UIButton lh_buttonWithFrame:CGRectZero target:self action:@selector(loginAction:) title:@"登录" titleColor:kWhiteColor font:FONT(16) backgroundColor:kClearColor];
    [bgView addSubview:loginBtn];

   [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(15);
       make.right.mas_equalTo(-15);
        make.top.equalTo(passWordTextFiled.mas_bottom).with.offset(22);
        make.height.mas_equalTo(45);
       
   }];
    [loginBtn lh_setCornerRadius:45/2 borderWidth:1 borderColor:kWhiteColor];
    
    //其他登录方式
    
    UIButton *centerBtn = [UIButton lh_buttonWithFrame:CGRectZero target:self action:nil title:@"其他登录方式" titleColor:kWhiteColor font:FONT(14) backgroundColor:kClearColor];
    [bgView addSubview:centerBtn];
   [centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(bgView);
        make.top.equalTo(loginBtn.mas_bottom).with.offset(60);
       make.height.mas_equalTo(20);
       make.width.mas_equalTo(100);
      
    }];
   //左边的线
  UIView *leftLine = [UIView lh_viewWithFrame:CGRectZero backColor:kWhiteColor];
    [bgView addSubview:leftLine];

   [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
       make.left.mas_equalTo(15);
       make.top.equalTo(loginBtn.mas_bottom).with.offset(70);
       make.right.equalTo(centerBtn.mas_left).with.offset(-5);
       make.height.mas_equalTo(1);
       
    }];
    //右边的线
   UIView *rightLine = [UIView lh_viewWithFrame:CGRectZero backColor:kWhiteColor];
    [bgView addSubview:rightLine];

    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(centerBtn.mas_right).with.offset(5);
       make.top.equalTo(loginBtn.mas_bottom).with.offset(70);
        make.right.mas_equalTo(-15);
      make.height.mas_equalTo(1);
       
    }];
   
    
    CGFloat btn_W = SCREEN_WIDTH/3;
    //qq
    UIButton *qqBtn = [UIButton lh_buttonWithFrame:CGRectZero target:self action:@selector(qqLoginAction:) image:[UIImage imageNamed:@"QQ"]];
    [bgView addSubview:qqBtn];
    [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(leftLine.mas_bottom).with.offset(25);
        make.left.mas_equalTo(0);
        make.height.width.mas_equalTo(btn_W);
    }];
   
   //微博
     UIButton *weiboBtn = [UIButton lh_buttonWithFrame:CGRectZero target:self action:@selector(weiboLoginAction:) image:[UIImage imageNamed:@"weibo"]];
   [bgView addSubview:weiboBtn];
    [weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftLine.mas_bottom).with.offset(25);
        make.left.mas_equalTo(btn_W);
        make.height.width.mas_equalTo(btn_W);
        
    }];
    
    //微信
    UIButton *weChatBtn = [UIButton lh_buttonWithFrame:CGRectZero target:self action:@selector(weChatLoginAction:) image:[UIImage imageNamed:@"weChat"]];
    [bgView addSubview:weChatBtn];
    [weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftLine.mas_bottom).with.offset(25);
        make.left.mas_equalTo(2*btn_W);
        make.height.width.mas_equalTo(btn_W);
    }];
  

    
}

- (void)backAction:(UIButton *)btn {
    
    [self.navigationController popVC];

}

- (void)loginAction:(UIButton *)btn {

    [self.navigationController popToRootVC];


}
- (void)qqLoginAction:(UIButton *)btn{

    
}
- (void)weiboLoginAction:(UIButton *)btn{
   

}
- (void)weChatLoginAction:(UIButton *)btn{
    

}



@end
