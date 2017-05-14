//
//  HXMyAccountInfoVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyAccountInfoVC.h"
#import "HXAccountHead.h"
#import "HXBalanceRechargeVC.h"
#import "HXMyAssetAPI.h"
#import "HXDealRecordVC.h"
#import "HXAccountReChargeVC.h"

@interface HXMyAccountInfoVC ()
{

    HXAccountHead *headView;
}
@property (strong, nonatomic)  NSString *balance;


@end

@implementation HXMyAccountInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];

   self.title = @"我的资产";
  
    [self getMyAssetData];
    
    headView = [HXAccountHead initWithAccountHeadWithXib];
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    self.tableV.tableHeaderView = headView;

    UIButton *dealRecordBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0,80, 60) target:self action:@selector(dealRecordAction) backgroundImage:nil title:@"交易记录" titleColor:kDarkGrayColor font:FONT(16)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:dealRecordBtn];
                
                
}
- (void)getMyAssetData{

  [[[HXMyAssetAPI getMyAsset] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
     
      headView.balanceLabel.text = [NSString stringWithFormat:@"￥%@",responseObject[@"pd"][@"balance"]];
      self.balance = [NSString stringWithFormat:@"%@",responseObject[@"pd"][@"balance"]] ;
      [self.tableView reloadData];
  }];

}
- (NSArray *)groupTitles {
    
    return @[@[@"余额提现（100元起提现）"],@[@"账户充值"]];
}

- (NSArray *)groupIcons {
    
    return @[@[@""],@[@""]];
}

- (NSArray *)groupDetials {
    
    return @[@[@""],@[@""]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        HXBalanceRechargeVC *vc = [[HXBalanceRechargeVC alloc]initWithNibName:@"HXBalanceRechargeVC" bundle:nil];
        vc.balance = self.balance;
        [self.navigationController pushVC:vc];
        
    }else {
        HXAccountReChargeVC *vc = [HXAccountReChargeVC new];
        [self.navigationController pushVC:vc];
    
    }
}
- (void)dealRecordAction {

    HXDealRecordVC *vc = [HXDealRecordVC new];
    [self.navigationController pushVC:vc];

}
@end
