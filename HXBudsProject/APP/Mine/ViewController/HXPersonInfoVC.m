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
#import "HXeditInfoVC.h"

@interface HXPersonInfoVC ()
@property(nonatomic,strong)NSMutableArray *testArr;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *hobby;
@property(nonatomic,strong)UITextView *introduce;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *age;
@property(nonatomic,strong)UILabel *sexLabel;
@property(nonatomic,strong)UILabel *ageLabel;
@property(nonatomic,strong)HXUploadIconModel *uploadIconModel;
@property(nonatomic,strong)HXUserInfoModel *userModel;
@property(nonatomic,strong)NSMutableArray *infoArr;

@end

@implementation HXPersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title = @"个人信息";

    UIButton *saveBtn = [UIButton lh_buttonWithFrame:CGRectMake(50, 0, 60, 80) target:self action:@selector(saveAction:) title:@"保存" titleColor:APP_COMMON_COLOR font:FONT(16) backgroundColor:kClearColor];
    UIBarButtonItem *rightBarItem =  [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    saveBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [saveBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    self.tableV.backgroundColor = KVCBackGroundColor;
    
    
    [self getMyInfoData];
}
- (void)getMyInfoData{
    
    [[[HXgetUserInfoAPI getUserInfo] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        HXUserInfoModel *api = [HXUserInfoModel new];
        self.userModel = [api.class mj_objectWithKeyValues:responseObject];
        
        //昵称
        HJSettingItem *selectItem1 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] ];
        selectItem1.detailTitle = self.userModel.pd.nickname?self.userModel.pd.nickname:@"";
        //手机
        HJSettingItem *selectItem2 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] ];
        selectItem2.detailTitle = self.userModel.pd.phone?self.userModel.pd.phone:@"";
        //姓名
        HJSettingItem *selectItem3 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] ];
        selectItem3.detailTitle = self.userModel.pd.username?self.userModel.pd.username:@"";
        //性别
        HJSettingItem *selectItem4 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] ];
        NSString *sex;
                if ([self.userModel.pd.sex isEqualToString:@"2"]) {
                    sex = @"女";
                }else if ([self.userModel.pd.sex isEqualToString:@"1"]){
                    sex = @"男";
                }else{
                   sex = @"";
                }
        selectItem4.detailTitle = sex?sex:@"";
        //出生日期
        HJSettingItem *selectItem5 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] ];
        selectItem5.detailTitle = self.userModel.pd.age?self.userModel.pd.age:@"0";
        //个人描述
        HJSettingItem *selectItem6 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
        selectItem6.detailTitle = self.userModel.pd.hobby?self.userModel.pd.hobby:@"0";
        [self.tableV reloadData];
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
    
    self.uploadIconModel = [HXUploadIconModel read];
    
    //昵称
    HJSettingItem *selectItem1 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] ];
    NSString *nickName = selectItem1.detailTitle;
    //手机
    HJSettingItem *selectItem2 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] ];
    NSString *phone = selectItem2.detailTitle;

    //姓名
    HJSettingItem *selectItem3 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] ];
    NSString *userName = selectItem3.detailTitle;
    //性别
    HJSettingItem *selectItem4 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] ];
    NSString *sex = [selectItem4.detailTitle isEqualToString:@"男"]?@"1":@"2";

    //出生日期
    HJSettingItem *selectItem5 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] ];
    NSString *birthDay = selectItem5.detailTitle;
    
    //个人描述
    HJSettingItem *selectItem6 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    NSString *desc = selectItem6.detailTitle;

//   NSString *validMsg = [self validMsg];
//    if (validMsg) {
//        [SVProgressHUD showInfoWithStatus:validMsg];
//    }else{
//
    [[[HXModifyUserInfoAPI ModifyUserInfoWithNickname:nickName username:userName phone:phone sex:sex age:birthDay hobby:desc headportrait:self.uploadIconModel.path] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        [self.navigationController popVC];
    }];
    
//    }

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
    
    return @[@[@"头像",@"昵称",@"手机",@"姓名",@"性别",@"出生日期",@"个人描述"]];
}

- (NSArray *)groupIcons {
    
    return @[@[@" ",@" ",@" ",@" ",@" ",@" ",@" "]];
    
}

- (NSArray *)indicatorIndexPaths {
    NSMutableArray *indexpathArr = [NSMutableArray array];
    for (NSInteger i = 1; i< 7; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexpathArr addObject:indexpath];
    }
    return indexpathArr;
}
- (NSArray *)groupDetials {
    
    return @[@[@" ",@"",@"",@"",@"",@"",@""]];
}

- (NSIndexPath *)headImageCellIndexPath{

    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];

    return indexpath;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 0) {
        if ([self.userModel.pd.headportrait containsString:@"http:"]) {
            [self.cellHeadImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.pd.headportrait] placeholderImage:[UIImage imageNamed:@"person_ico"]];
        }else{
            
        [self.cellHeadImageView sd_setImageWithURL:[NSURL URLWithString:kAPIUserImageFromUrl(self.userModel.pd.headportrait)] placeholderImage:[UIImage imageNamed:@"person_ico"]];
        }
    }
        return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
     return 70;

    }else{
        
        return  44;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 0.001;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXeditInfoVC *vc = [HXeditInfoVC new];

    if (indexPath.row == 0) {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }else if (indexPath.row == 1){
        vc.personIntroduce = NO;
        vc.titleStr = @"昵称";
        vc.itemBlock = ^(NSString *item) {
            HJSettingItem *selectItem = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] ];
            selectItem.detailTitle = item;
            [self.tableV reloadData];
        };
        [self.navigationController pushVC:vc];
        
    }else if (indexPath.row == 2){
        vc.personIntroduce = NO;
        vc.itemBlock = ^(NSString *item) {
            HJSettingItem *selectItem = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] ];
            selectItem.detailTitle = item;
            [self.tableV reloadData];
        };
        vc.titleStr = @"手机";
        [self.navigationController pushVC:vc];
    }else if (indexPath.row == 3){
        vc.personIntroduce = NO;
        vc.itemBlock = ^(NSString *item) {
            HJSettingItem *selectItem = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] ];
            selectItem.detailTitle = item;
        [self.tableV reloadData];
        };
        vc.titleStr = @"姓名";
        [self.navigationController pushVC:vc];
    }else if (indexPath.row == 4) {
        //性别
        HXCommonPickView *pickView = [[HXCommonPickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        pickView.style = HXCommonPickViewStyleSex;
        [pickView showPickViewAnimation:YES];
        
        pickView.completeBlock = ^(NSString *selectedItem){
            HJSettingItem *selectItem = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] ];
            selectItem.detailTitle = selectedItem;
            if ([selectedItem isEqualToString:@"男"]) {
                self.sex = @"1";
            }else if([selectedItem isEqualToString:@"女"]){
                self.sex = @"2";
            }
            [self.tableV reloadData];
        };
        
    }else if(indexPath.row == 5){
        //出生日期
        HXCommonPickView *pickView = [[HXCommonPickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        pickView.style = HXCommonPickViewStyleDate;
        [pickView showPickViewAnimation:YES];
        
        pickView.completeBlock = ^(NSString *selectedItem){
            HJSettingItem *selectItem = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] ];
            selectItem.detailTitle = selectedItem;
            [self.tableV reloadData];
        };
    }else{
        vc.personIntroduce = YES;
        vc.itemBlock = ^(NSString *item) {
            HJSettingItem *selectItem = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:6 inSection:0] ];
            selectItem.detailTitle = item;
            [self.tableV reloadData];

        };
        vc.titleStr = @"个人描述";
        [self.navigationController pushVC:vc];
    }

}
@end
