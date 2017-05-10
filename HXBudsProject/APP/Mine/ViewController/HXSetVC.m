//
//  HXSetVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSetVC.h"
#import "HXAccountSecutityVC.h"
@interface HXSetVC ()

@end

@implementation HXSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
      self.title = @"设置";
    
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80) backColor:kWhiteColor];
    
    UIButton *exitBtn = [UIButton lh_buttonWithFrame:CGRectMake(30, 10, SCREEN_WIDTH - 60, 35) target:self action:@selector(exitBtnAction) image:nil];
    [exitBtn setTitleColor:kRedColor forState:UIControlStateNormal];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn lh_setCornerRadius:3 borderWidth:1 borderColor:kRedColor];
    [footView addSubview:exitBtn];
    self.tableV.tableFooterView = footView;
    
}
- (NSArray *)groupTitles {
    
    return @[@[@"账号安全",@"帮助中心",@"当前版本",@"清除缓存"]];
}

- (NSArray *)groupIcons {
    
    return @[@[@"",@"",@"",@""]];
}

- (NSArray *)groupDetials {
    
    return @[@[@"",@"",@"2.0",@"10M"]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        
        HXAccountSecutityVC *vc = [HXAccountSecutityVC new];
        [self.navigationController pushVC:vc];
        
    }
}
- (void)exitBtnAction{

    HJUser *user = [HJUser sharedUser];
    user.pd.token = @"";
    user.pd.users_id = @"";
    [user write];
    [self.navigationController popVC];
}
@end
