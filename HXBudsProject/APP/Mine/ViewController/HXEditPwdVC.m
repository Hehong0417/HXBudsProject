//
//  HXForgetPwdVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/11.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXEditPwdVC.h"
#import "HXTextFieldCell.h"
#import "HXEditPwdAPI.h"
#import "HXLoginVC.h"


@interface HXEditPwdVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *leftTitleArr;

@end

@implementation HXEditPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    [self.view addSubview:self.tableView];
    
    UIButton *finishBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 60, 60) target:self action:@selector(finishAction) backgroundImage:nil title:@"完成" titleColor:APP_COMMON_COLOR font:FONT(14)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:finishBtn];
    
    self.leftTitleArr = @[@"原密码",@"新密码",@"确认密码"];
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
    return cell;
    
}
- (NSString *)isValidWitholdPwdStr:(NSString *)oldPwdStr newPwdStr:(NSString *)newPwdStr  commitPwdStr:(NSString *)commitPwdStr{
    
    if (oldPwdStr.length == 0) {
        return @"请输入原密码！";
    }else if (newPwdStr.length == 0){
        return @"请输入新密码！";
    }else if (commitPwdStr.length == 0){
        return @"请输入确认密码！";
    }else if (![commitPwdStr isEqualToString:newPwdStr]){
        return @"两次输入的密码不一致！";
    }
    return nil;
}
- (void)finishAction {

    HXTextFieldCell *cell0 = (HXTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *oldPwdStr = cell0.textFiled.text;
    
    HXTextFieldCell *cell1 = (HXTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *newPwdStr = cell1.textFiled.text;
    
    HXTextFieldCell *cell2 = (HXTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *commitPwdStr = cell2.textFiled.text;
    
   
    
    NSString *isValid =  [self isValidWitholdPwdStr:oldPwdStr newPwdStr:newPwdStr commitPwdStr:commitPwdStr];
    NSLog(@"%@---%@",oldPwdStr,newPwdStr);
    if (!isValid) {
        
       [[[HXEditPwdAPI editPwdWithOldpassword:oldPwdStr.md5String NewPwd:newPwdStr.md5String] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
           if (error==nil) {
           NSString *pwdNo = responseObject[@"pd"][@"state"];
           
           if ([pwdNo isEqualToString:@"pwdNo"]) {
               [SVProgressHUD setMinimumDismissTimeInterval:1.0];

               [SVProgressHUD showInfoWithStatus:@"原密码输入错误！"];
               
           }else if ([pwdNo isEqualToString:@"yes"]){
               [SVProgressHUD setMinimumDismissTimeInterval:1.0];

               [SVProgressHUD showSuccessWithStatus:@"密码修改成功"];
               [self.navigationController popToRootVC];
           }
           }
       }];
    }else{
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];

        [SVProgressHUD showInfoWithStatus:isValid];
        
    }
    
    
}

@end
