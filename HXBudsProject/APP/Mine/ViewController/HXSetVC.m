//
//  HXSetVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSetVC.h"
#import "HXAccountSecutityVC.h"
#import "HXIsLoginAPI.h"
#import "HXLoginVC.h"
#import "HXSWiStateModel.h"
@interface HXSetVC ()
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) UISwitch *swi;

@property (nonatomic, assign) BOOL swiState;

@end

@implementation HXSetVC

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
      self.title = @"设置";
    
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80) backColor:KVCBackGroundColor];
    
    
    UIButton *exitBtn = [UIButton lh_buttonWithFrame:CGRectMake(30, 30, SCREEN_WIDTH - 60, 35) target:self action:@selector(exitBtnAction) image:nil];
    [exitBtn setTitleColor:kRedColor forState:UIControlStateNormal];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn lh_setCornerRadius:3 borderWidth:1 borderColor:kRedColor];
    exitBtn.backgroundColor = kWhiteColor;
    [footView addSubview:exitBtn];
    self.tableV.tableFooterView = footView;
    
    HJLoginModel *loginModel = [HJUser sharedUser].pd;
    [[[HXIsLoginAPI isLoginWithToken:loginModel.token] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        if (error==nil) {
        NSString *isLoginStr = responseObject[@"pd"][@"islogin"];
        if ([isLoginStr isEqualToString:@"no"]) {
            self.isLogin = NO;
        }else {
            self.isLogin = YES;
        }
        }
        if (error) {
            self.isLogin = NO;
        }
    }];

}
- (NSArray *)groupTitles {
    
    return @[@[@"账号安全",@"仅WI-FI观看",@"帮助中心",@"当前版本",@"清除缓存"]];
}

- (NSArray *)groupIcons {
    
    return @[@[@"",@"",@"",@"",@""]];
}

- (NSArray *)groupDetials {
    
    return @[@[@"",@"",@"",@"2.0",@"10M"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
        UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 1) {

        HXSWiStateModel *model = [HXSWiStateModel read];
        [self.swi setOn:model.state];
        cell.accessoryView = self.swi;

    }
        return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        
        if (self.isLogin) {
            HXAccountSecutityVC *vc = [HXAccountSecutityVC new];
            [self.navigationController pushVC:vc];
        }else{
            HXLoginVC *vc = [HXLoginVC new];
            [self.navigationController pushVC:vc];
         
        }
    }
}
- (void)swiValueChange:(UISwitch *)swi{

    HXSWiStateModel *model = [HXSWiStateModel read];
    model.state = swi.isOn;
    [model write];
}
- (UISwitch *)swi {

    if (!_swi) {
        _swi = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 70, 35)];
        [_swi addTarget:self action:@selector(swiValueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _swi;
}
- (void)exitBtnAction{

    HJUser *user = [HJUser sharedUser];
    user.pd.token = @"";
    user.pd.users_id = @"";
    [user write];
    [self.navigationController popVC];
}
@end
