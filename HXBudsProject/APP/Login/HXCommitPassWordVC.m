//
//  HXCommitPassWordVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/26.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCommitPassWordVC.h"
#import "HJTabBarController.h"
#import "HXRegisterAPI.h"
#import "HXLoginAPI.h"
#import "HJUser.h"

@interface HXCommitPassWordVC ()
{
    UITextField *phoneNumTextFiled;
    UITextField *passWordTextFiled;
}
@property(nonatomic,strong) HJUser *user;
@end

@implementation HXCommitPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏背景图片
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    UIColor *leftColor =  RGB(0, 215, 92);
    UIColor *rightColor =  RGB(0, 173, 223);
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
    
    
    phoneNumTextFiled = [UITextField lh_textFieldWithFrame:CGRectZero placeholder:nil font:FONT(15) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    phoneNumTextFiled.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请设置6位数以上的密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    phoneNumTextFiled.leftViewMode = UITextFieldViewModeAlways;
    UIButton *btn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 40, WidthScaleSize_H(45)) target:self action:nil image:[UIImage imageNamed:@"phoneNum"]];
    // btn.backgroundColor = kClearColor;
    phoneNumTextFiled.textColor = kWhiteColor;
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
     passWordTextFiled.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"确认密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    passWordTextFiled.textColor = kWhiteColor;
    passWordTextFiled.leftViewMode = UITextFieldViewModeAlways;
    
    passWordTextFiled.leftView = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 40, WidthScaleSize_H(45)) target:self action:nil image:[UIImage imageNamed:@"passWord"]];;
    [passWordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.centerX.equalTo(bgView);
        make.top.equalTo(phoneNumTextFiled.mas_bottom).with.offset(WidthScaleSize_H(22));
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(WidthScaleSize_H(45));
    }];
    [passWordTextFiled lh_setCornerRadius:WidthScaleSize_H(45)/2 borderWidth:0 borderColor:nil];
    
    
    //login按钮
    UIButton *registerBtn = [UIButton lh_buttonWithFrame:CGRectZero target:self action:@selector(registerAction:) title:@"登录" titleColor:kWhiteColor font:FONT(16) backgroundColor:kClearColor];
    [bgView addSubview:registerBtn];
    
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(passWordTextFiled.mas_bottom).with.offset(WidthScaleSize_H(22));
        make.height.mas_equalTo(WidthScaleSize_H(45));
        
    }];
    [registerBtn lh_setCornerRadius:WidthScaleSize_H(45)/2 borderWidth:1 borderColor:kWhiteColor];
    
    
}
- (void)registerAction:(UIButton *)btn{
    
    //判断密码是否相同
  NSString *validMsg = [self validAllMsg];
    if (!validMsg) {
        //注册
        [self registerRequest];
    }else {
        
    [SVProgressHUD showInfoWithStatus:validMsg];
        
    }
}
- (void)backAction:(UIButton *)btn {
    
    [self.navigationController popVC];
    
}
- (NSString *)validAllMsg{

    if (phoneNumTextFiled.text.length == 0) {
        
        return  @"设置密码不能为空！";
        
    }else if(passWordTextFiled.text.length == 0) {
        
        return  @"请再次输入密码！";
        
    }else if(![passWordTextFiled.text isEqualToString:phoneNumTextFiled.text]){
        return  @"两次密码输入不一致";
    }
    
   return nil;

}
- (void)registerRequest{
    
    NSString *md5PwdStr = [passWordTextFiled.text md5String];
    
     [[[HXRegisterAPI registerWithPhoneNum:self.phoneNum password:md5PwdStr] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
     
         [self loginRequest];

     }];

}
- (void)loginRequest{
    
    NSString *md5PwdStr = [passWordTextFiled.text md5String];

   [[[HXLoginAPI loginWithPhoneNum:self.phoneNum password:md5PwdStr] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
       
       //保存登录模型
       self.user = [[HJUser sharedUser].class mj_objectWithKeyValues:responseObject];
       [self.user write];
       [self.navigationController popToRootVC];
       
   }];

}
@end
