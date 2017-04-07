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
#import "HXMineLoginHeadView.h"
#import "HXMyArticleVC.h"
#import "HXMyAttetionVC.h"
#import "HXFriendDynamicStateVC.h"
#import "HXAdviceFaceBackVC.h"
#import "HXBrowserRecordVC.h"
#import "HXMessageVC.h"
#import "HXMyVideoVC.h"


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
    mineHeadView.frame = CGRectMake(0, -20, SCREEN_WIDTH, WidthScaleSize_H(120));
    mineHeadView.nav = self.navigationController;

//    HXMineLoginHeadView *mineHeadView = [HXMineLoginHeadView initMineLoginHeadViewWithXib];
//    mineHeadView.frame = CGRectMake(0, -20, SCREEN_WIDTH, WidthScaleSize_H(120));
//    mineHeadView.nav = self.navigationController;
    
    [mineHeadView setTapActionWithBlock:^{
        
        HXMyLikeVC *vc = [HXMyLikeVC new];
        vc.titleStr = @"我的主页";
        [self.navigationController pushVC:vc];
        
    }];
    self.tableV.tableHeaderView = mineHeadView;

    
}
- (NSArray *)groupTitles {

    return @[@[@""],@[@"我的资产",@"我的消息",@"我关注的",@"好友动态"],@[@"浏览记录",@"分享萌芽APP",@"意见反馈",@"给我们好评~~"],@[@"仅在WI-Fi下播放"]];
}

- (NSArray *)groupIcons {
    
    return @[@[@""],@[@"mine_0",@"mine_1",@"mine_2",@"mine_3"],@[@"mine_4",@"mine_5",@"mine_6",@"mine_7"],@[@""]];
    
}

- (NSArray *)rightViewSwitchIndexPaths {
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:3];
    
    return @[indexpath];
}
- (NSArray *)groupDetials {
    
    return @[@[@""],@[@"",@"",@"",@""],@[@"",@"",@"",@""],@[@""]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        HXMineLearnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXMineLearnCell"];
        
        if (!cell) {
            
            cell = [HXMineLearnCell initMineCellWithXib];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
         [cell.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else {
     
        UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell;
        
    }
    return nil;
}

- (void)leftBtnAction:(UIButton *)btn {

    NSLog(@"left");
    //我的文章
    HXMyArticleVC *vc = [HXMyArticleVC new];
    [self.navigationController pushVC:vc];
    
}
- (void)rightBtnAction:(UIButton *)btn {
    
    NSLog(@"right");
    //我的视频
    HXMyVideoVC *vc = [HXMyVideoVC new];
    [self.navigationController pushVC:vc];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
        return WidthScaleSize_H(44);
    

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1) {
        
        [self didSelectRowAtSection0:indexPath.row];
        
    }else if (indexPath.section == 2){
    
        [self didSelectRowAtSection1:indexPath.row];
    }

}

- (void)didSelectRowAtSection0:(NSInteger )row{
   
    if (row == 0) {
        
        HXMyAccountInfoVC *vc = [HXMyAccountInfoVC new];
        [self.navigationController pushVC:vc];

    }else if (row == 1){
        HXMessageVC *vc = [HXMessageVC new];
        [self.navigationController pushVC:vc];

    }else if (row == 2){
        HXMyAttetionVC *vc = [HXMyAttetionVC new];
        [self.navigationController pushVC:vc];

    }else if (row == 3){
        HXFriendDynamicStateVC *vc = [HXFriendDynamicStateVC new];
        [self.navigationController pushVC:vc];
    
    }
}
- (void)didSelectRowAtSection1:(NSInteger)row{
    
    if (row == 0) {
        HXBrowserRecordVC *vc = [HXBrowserRecordVC new];
        [self.navigationController pushVC:vc];
        
    }else if (row == 1){
        
        
    }else if (row == 2){
        HXAdviceFaceBackVC *vc = [HXAdviceFaceBackVC new];
        [self.navigationController pushVC:vc];
        
    }else if (row == 3){
       
        
        
    }

}
- (void)LearnBtnActionWithIndex:(NSInteger)index {




}

@end
