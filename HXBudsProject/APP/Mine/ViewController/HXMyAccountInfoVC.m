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

@interface HXMyAccountInfoVC ()


@end

@implementation HXMyAccountInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];

   self.title = @"我的资产";
  
    HXAccountHead *headView = [[HXAccountHead alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 169)];
    headView.backgroundColor = RGB(2, 192, 186);
    self.tableV.tableHeaderView = headView;

}
- (NSArray *)groupTitles {
    
    return @[@[@"我的银行卡",@"我的优惠券"],@[@"交易记录"]];
}

- (NSArray *)groupIcons {
    
    return @[@[@"property_0",@"property_1"],@[@"property_2"]];
}

- (NSArray *)groupDetials {
    
    return @[@[@" ",@" "],@[@" "]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
          //我的银行卡
            
          
        }else if(indexPath.row == 1){
          //我的优惠券
            HXCouponVC *vc = [HXCouponVC new];
            [self.navigationController pushVC:vc];
            
        }
    }else{
    //交易记录
      
    
    }


}
@end
