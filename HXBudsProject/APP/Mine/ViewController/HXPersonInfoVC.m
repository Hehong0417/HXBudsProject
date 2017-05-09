//
//  HXPersonInfoVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/2.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXPersonInfoVC.h"
#import "HXCommonPickView.h"
#import "HXgetUserInfoAPI.h"
#import "HXModifyUserInfoAPI.h"
#import "HXUploadIconModel.h"
#import "HXUserInfoModel.h"


@interface HXPersonInfoVC ()
@property(nonatomic,strong)NSMutableArray *testArr;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *hobby;
@property(nonatomic,strong)IQTextView *introduce;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *age;
@property(nonatomic,strong)UILabel *sexLabel;
@property(nonatomic,strong)UILabel *ageLabel;
@property(nonatomic,strong)HXUploadIconModel *uploadIconModel;
@property(nonatomic,strong)HXUserInfoModel *userModel;

@end

@implementation HXPersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title = @"个人信息";

    UIButton *saveBtn = [UIButton lh_buttonWithFrame:CGRectMake(50, 0, 60, 80) target:self action:@selector(saveAction:) title:@"保存" titleColor:APP_COMMON_COLOR font:FONT(16) backgroundColor:kClearColor];
    UIBarButtonItem *rightBarItem =  [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    saveBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [saveBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    self.tableV.backgroundColor = KVCBackGroundColor;
    
    
    [self getMyInfoData];
}
- (void)getMyInfoData{
    
    [[[HXgetUserInfoAPI getUserInfo] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        

    }];
    
}
- (NSMutableArray *)testArr{
    if (!_testArr) {
        _testArr = [NSMutableArray array];
    }
    return _testArr;
}
- (void)saveAction:(UIButton *)btn{

    [self.view endEditing:YES];
    
    self.hobby = self.introduce.text;
    self.uploadIconModel = [HXUploadIconModel read];

   NSString *validMsg = [self validMsg];
    if (validMsg) {
        [SVProgressHUD showInfoWithStatus:validMsg];
    }else{
//        
//    [[[HXModifyUserInfoAPI ModifyUserInfoWithNickname:self.nickName username:self.name phone:self.phone sex:self.sex age:self.age hobby:self.hobby headportrait:self.uploadIconModel.path] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
//        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//        [self.navigationController popVC];
//
//    }];
    
    }

}
- (NSString *)validMsg{
    
    if (!self.nickName) {
        return @"请输入昵称";
    }else if(!self.name){
    
        return @"请输入姓名";
    }else if(!self.phone){
     
        return @"请输入手机号";
    }else if(!self.hobby){
        return @"请输入个人描述";
    }else if(!self.sex){
        return @"请选择性别";
    }else if(!self.age){
        return @"请选择年龄";
    }else if(!self.uploadIconModel.path){
        return @"请选择头像";
    }else{
        return nil;
    }
}


- (NSArray *)groupTitles {
    
    return @[@[@"头像",@"昵称",@"手机",@"姓名",@"性别",@"出生日期"],@[@""]];
}

- (NSArray *)groupIcons {
    
    return @[@[@" ",@" ",@" ",@" ",@" ",@" "],@[@""]];
    
}


- (NSArray *)groupDetials {
    
    return @[@[@" ",@" ",@" ",@" ",@" ",@" "],@[@""]];
}
- (NSArray *)textFieldCellIndexPaths{
    
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
    NSIndexPath *indexPath3 = [NSIndexPath indexPathForRow:3 inSection:0];
    
    return @[indexPath1,indexPath2,indexPath3];
    
}
- (NSIndexPath *)headImageCellIndexPath{

    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];

    return indexpath;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.row == 4) {
            self.sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(114, 0, SCREEN_WIDTH-44, WidthScaleSize_H(44))];
            [cell.contentView addSubview:self.sexLabel];
        }else if(indexPath.row == 5){
            self.ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(114, 0, SCREEN_WIDTH-44, WidthScaleSize_H(44))];
            [cell.contentView addSubview:self.ageLabel];
        
        }
        return cell;

    }else{
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        self.introduce = [[IQTextView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, WidthScaleSize_H(100))];
        self.introduce.font = FONT(14);
        self.introduce.placeholder = @"个人概述";
        
        [cell addSubview:self.introduce];
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0&&indexPath.row == 0) {
        
        return 70;

    }else if (indexPath.section == 1&&indexPath.row == 0){
    
        return 100;

    }else{
        
        return  44;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        UIView *head = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20) backColor:LineLightColor];
        UILabel *Label = [UILabel lh_labelWithFrame:CGRectMake(15, 0, 100, 20) text:@"个人概述" textColor:FontLightGrayColor font:FONT(13) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
        [head addSubview:Label];
        return head;

    }else{
   
     return nil;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.001;
    }else{
        return 20;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 4) {
        //性别
        HXCommonPickView *pickView = [[HXCommonPickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        pickView.style = HXCommonPickViewStyleSex;
        [pickView showPickViewAnimation:YES];
        
        pickView.completeBlock = ^(NSString *selectedItem){
            self.sexLabel.text = selectedItem;
            if ([selectedItem isEqualToString:@"男"]) {
                self.sex = @"1";
            }else if([selectedItem isEqualToString:@"女"]){
                self.sex = @"2";
            }
        };
        
    }else if(indexPath.row == 5){
        //出生日期
        HXCommonPickView *pickView = [[HXCommonPickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        pickView.style = HXCommonPickViewStyleDate;
        [pickView showPickViewAnimation:YES];
        
        pickView.completeBlock = ^(NSString *selectedItem){
            self.ageLabel.text = selectedItem;
            self.age = selectedItem;
        };
    }else{
    
        [super  tableView:tableView didSelectRowAtIndexPath:indexPath];
    }

}
#pragma mark - textFiledDelegate

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 1) {
        self.nickName = textField.text;
        
    }
    if (textField.tag == 2) {
        self.phone = textField.text;
    }
    if (textField.tag == 3) {
        self.name = textField.text;
    }
    
    
}
@end
