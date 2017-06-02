//
//  HXAccountSecutityVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXAccountSecutityVC.h"
#import "HXEditPwdVC.h"
#import "HXPersonInfoVC.h"


@interface HXAccountSecutityVC ()

@end

@implementation HXAccountSecutityVC

- (void)viewDidLoad {
    [super viewDidLoad];

   self.title = @"账号安全";

}
- (NSArray *)groupTitles {
    
    return @[@[@"个人信息设置",@"手机号设置",@"密码修改",@"微信绑定"]];
}

- (NSArray *)groupIcons {
    
    return @[@[@"",@"",@"",@""]];
}

- (NSArray *)groupDetials {
    
    return @[@[@"",@"13825645589",@"",@""]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        [self.navigationController pushVC:[HXPersonInfoVC new]];
        
    }else if (indexPath.row == 2) {
        
        [self.navigationController  pushVC:[HXEditPwdVC new]];
    }

}

@end
