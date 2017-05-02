//
//  HXMyAccountInfoVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyAccountInfoVC.h"
#import "HXAccountHead.h"
#import "HXCouponVC.h"
#import "HXBalanceRechargeVC.h"


@interface HXMyAccountInfoVC ()


@end

@implementation HXMyAccountInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];

   self.title = @"我的资产";
  
    HXAccountHead *headView = [[HXAccountHead alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 169)];
    headView.backgroundColor = RGB(2, 192, 186);
    self.tableV.tableHeaderView = headView;
   [headView.balanceRechargeBgView setTapActionWithBlock:^{
       
       HXBalanceRechargeVC *vc = [[HXBalanceRechargeVC alloc]initWithNibName:@"HXBalanceRechargeVC" bundle:nil];
       [self.navigationController pushVC:vc];
       
   }];
}
- (NSArray *)groupTitles {
    
    return @[@[@"交易记录"]];
}

- (NSArray *)groupIcons {
    
    return @[@[@"property_2"]];
}

- (NSArray *)groupDetials {
    
    return @[@[@" "]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


}
@end
