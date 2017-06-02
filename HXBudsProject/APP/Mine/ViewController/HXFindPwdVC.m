//
//  HXFindPwdAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/11.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXFindPwdVC.h"
#import "HXTextFieldCell.h"
#import "LHVerifyCodeButton.h"
#import "HXVerifyPhoneNumAPI.h"
#import "HXGetVerifyCodeAPI.h"
#import "HXForgetPwdAPI.h"
#import "HXLoginVC.h"
@interface HXFindPwdVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *leftTitleArr;
@property(nonatomic,strong)LHVerifyCodeButton *verifyCodeBtn;
@property(nonatomic,strong)NSString *verifyCode;

@end

@implementation HXFindPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    [self.view addSubview:self.tableView];
    
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35) backColor:kWhiteColor];
    
    UIButton *finishBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 60, 60) target:self action:@selector(finishAction) backgroundImage:nil title:@"确认修改" titleColor:kWhiteColor font:FONT(14)];
    finishBtn.backgroundColor = APP_COMMON_COLOR;
    [finishBtn lh_setCornerRadius:5 borderWidth:0 borderColor:nil];
    [footView addSubview:finishBtn];
    
    self.leftTitleArr = @[@"请输入手机号",@"请输入验证码",@"设置新密码",@"确认新密码"];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.leftTitleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HXTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXTextFieldCell"];
    if(!cell){
        cell = [[HXTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HXTextFieldCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.leftTextLabel.text = self.leftTitleArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.textFiled.rightView = [UILabel lh_labelWithFrame:CGRectMake(0, 0, 100, 44) text:@"中国大陆+86" textColor:kBlackColor font:FONT(14) textAlignment:NSTextAlignmentCenter backgroundColor:kWhiteColor];
        cell.textFiled.rightViewMode = UITextFieldViewModeAlways;
        cell.textFiled.secureTextEntry = NO;
        cell.textFiled.delegate = self;

    }else if (indexPath.row == 1){
        
        self.verifyCodeBtn = [[LHVerifyCodeButton alloc]initWithFrame:CGRectMake(0, 4, 80, 36)];
        [self.verifyCodeBtn addTarget:self action:@selector(sendVerifyCode) forControlEvents:UIControlEventTouchUpInside];
        [self.verifyCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [self.verifyCodeBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
        [self.verifyCodeBtn lh_setCornerRadius:5 borderWidth:1 borderColor:kGrayColor];
        cell.textFiled.rightView = self.verifyCodeBtn;
        cell.textFiled.rightViewMode = UITextFieldViewModeAlways;
        
        cell.textFiled.secureTextEntry = NO;

    }else{
     
        cell.textFiled.secureTextEntry = YES;
    }
    return cell;
    
}
- (void)sendVerifyCode{
    
    //判断手机号是否填写--手机号是否存在
    [self checkPhoneOnly];

}
#pragma mark-手机号唯一性验证
- (void)checkPhoneOnly
{
    HXTextFieldCell *cell = (HXTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell.textFiled.text.length == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];

        [SVProgressHUD showInfoWithStatus:@"请先填写手机号"];
    }else{
        
        BOOL isvalidPhone = [NSString valiMobile:cell.textFiled.text];
        if (!isvalidPhone) {
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];

            [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号"];
        }else {
            
            [[[HXVerifyPhoneNumAPI verifyPhoneNumWithPhoneNum:cell.textFiled.text] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
                if (error==nil) {
                NSNumber *state = responseObject[@"pd"][@"state"];
                if ([state isEqual:@0]) {
                    [SVProgressHUD setMinimumDismissTimeInterval:1.0];

                    [SVProgressHUD showInfoWithStatus:@"手机号不存在，请先进行注册"];
                    
                }else if ([state isEqual:@1]){
                    
                    [self sendverifyCodeRequest:cell.textFiled.text];
                    
                }
                }
            }];
        }
    
  }
}
#pragma mark-发送验证码请求

- (void)sendverifyCodeRequest:(NSString *)phoneNum
{
    [[[HXGetVerifyCodeAPI getVerifyCodeWithPhoneNum:phoneNum] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        
        if (error==nil) {
            
            [self.verifyCodeBtn startTimer:60];
            
            NSString *verifyCodeStr = responseObject[@"pd"][@"smscode"];
            
            self.verifyCode = verifyCodeStr;
            
        }
        
      }];
}

- (NSString *)isValidWithphoneStr:(NSString *)phoneStr verifyCodeStr:(NSString *)verifyCodeStr  newPwdStr:(NSString *)newPwdStr commitPwdStr:(NSString *)commitPwdStr{
    
    if (phoneStr.length == 0) {
        return @"请输入手机号！";
    }else if (verifyCodeStr.length == 0){
        return @"请输入验证码！";
    }else if (newPwdStr.length == 0){
        return @"请输入新密码！";
    }else if (commitPwdStr.length == 0){
        return @"请输入确认密码！";
    }else if (![commitPwdStr isEqualToString:newPwdStr]){
        return @"两次输入的密码不一致！";
    }else if (![verifyCodeStr isEqualToString:self.verifyCode]){
        return @"验证码输入不正确！";
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
- (void)finishAction {
    
    HXTextFieldCell *cell0 = (HXTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *phoneStr = cell0.textFiled.text;
    
    HXTextFieldCell *cell1 = (HXTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *verifyCodeStr = cell1.textFiled.text;
    
    HXTextFieldCell *cell2 = (HXTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *newPwdStr = cell2.textFiled.text;
    
    HXTextFieldCell *cell3 = (HXTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *commitPwdStr = cell3.textFiled.text;
    
    NSString *isValid =  [self isValidWithphoneStr:phoneStr verifyCodeStr:verifyCodeStr newPwdStr:newPwdStr commitPwdStr:commitPwdStr];
    
    if (!isValid) {
        
        [[[HXForgetPwdAPI FindPwdWithAcc:phoneStr NewPwd:newPwdStr.md5String] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
            if (error==nil) {
                [SVProgressHUD setMinimumDismissTimeInterval:1.0];
                
                [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
                [self.navigationController pushVC:[HXLoginVC new]];
            }
           
        }];

    }else{
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];

        [SVProgressHUD showInfoWithStatus:isValid];
    }
    
    
}
@end
