//
//  HXPersonCenterVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/7.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXPersonCenterVC.h"
#import "HXMineLearnCell.h"
#import "HXMineHeadView.h"
#import "HXMyAccountInfoVC.h"
#import "HXCouponVC.h"
#import "HXMyLikeVC.h"
#import "HXMyQuestionVC.h"

@interface HXPersonCenterVC ()<HXMineLearnCellDelegate>

@end

@implementation HXPersonCenterVC


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
   
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    HXMineHeadView *mineHeadView = [HXMineHeadView initmineHeadViewWithXib];
    mineHeadView.frame = CGRectMake(0, -20, SCREEN_WIDTH, WidthScaleSize_H(257));
    mineHeadView.nav = self.navigationController;
    mineHeadView.titleLab.text = @"我的";
    self.tableV.tableHeaderView = mineHeadView;
    
}
- (NSArray *)groupTitles {

    return @[@[@" ",@" "],@[@"分享有礼",@"我喜欢的",@"我的提问",@"历史记录"],@[@"操作指引",@"关于我们",@"仅在WI-Fi下播放"]];
}

- (NSArray *)groupIcons {
    
    return @[@[@" ",@" "],@[@"sharegift",@"mylike",@"question",@"historyRecord"],@[@"operatioGuide",@"about_me",@"ic_tab_04"]];

}

- (NSArray *)rightViewSwitchIndexPaths {
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:2 inSection:2];
    
    return @[indexpath];
}
- (NSArray *)groupDetials {
    
    return @[@[@"",@" "],@[@"",@"",@"",@""],@[@"",@"",@""]];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        HXMineLearnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXMineLearnCell"];
        
        if (!cell) {
            
            cell = [HXMineLearnCell initMineCellWithXib];
            
        }
        cell.leftBtn.tag = indexPath.row;
        cell.rightBtn.tag = indexPath.row;
        [cell.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        if (indexPath.row == 0) {
             cell.leftImageStr = @"coupon";
             cell.rightImageStr = @"buy";
             cell.leftTitleLab.text = @"   优惠券";
             cell.rightTitleLab.text = @"   已购买";
           
        }else{
            cell.leftImageStr = @"learning";
            cell.rightImageStr = @"my_account";
            cell.leftTitleLab.text = @"  学习进程";
            cell.rightTitleLab.text = @"  我的账户";
        }
        
        return cell;
        
    }else {
     
        UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell;
        
    }
    return nil;
}

- (void)leftBtnAction:(UIButton *)btn {
    
    if (btn.tag == 0) {
        
        HXCouponVC *couponVC = [HXCouponVC new];
        [self.navigationController pushVC:couponVC];
        
        
    }else if(btn.tag == 1){
    
    
    
    }
    
    
}
- (void)rightBtnAction:(UIButton *)btn {
    
    
    if (btn.tag == 0) {
        
        
    }else if(btn.tag == 1){
        
        HXMyAccountInfoVC *myAccount = [[[NSBundle mainBundle] loadNibNamed:@"HXMyAccountInfoVC" owner:nil options:nil] lastObject];
        [self.navigationController pushVC:myAccount];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        return WidthScaleSize_H(100);
    }else {
    
        return WidthScaleSize_H(44);
    
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1) {
        
        if (indexPath.row == 1) {
           //我喜欢的
            [self.navigationController pushVC:[HXMyLikeVC new]];
        }else if(indexPath.row == 2){
          //我的提问
            [self.navigationController pushVC:[HXMyQuestionVC new]];
        }
        
    }


}
- (void)LearnBtnActionWithIndex:(NSInteger)index {




}

@end
