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
#import "HXMyAssetAPI.h"

@interface HXMyAccountInfoVC ()
{

    HXAccountHead *headView;
}

@end

@implementation HXMyAccountInfoVC


- (void)viewDidLoad {
    [super viewDidLoad];

   self.title = @"我的资产";
  
    [self getMyAssetData];
    
    headView = [[HXAccountHead alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 169)];
    headView.backgroundColor = RGB(2, 192, 186);
    self.tableV.tableHeaderView = headView;
    WEAK_SELF();
   [headView.balanceRechargeBgView setTapActionWithBlock:^{
       
       HXBalanceRechargeVC *vc = [[HXBalanceRechargeVC alloc]initWithNibName:@"HXBalanceRechargeVC" bundle:nil];
       [weakSelf.navigationController pushVC:vc];
       
   }];
}
- (void)getMyAssetData{

  [[[HXMyAssetAPI getMyAsset] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
     
      headView.balanceLabel.text = responseObject[@"balance"];
      
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
