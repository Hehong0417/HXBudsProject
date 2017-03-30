//
//  HXHomePageTVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/7.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXHomePageTVC.h"
#import "SDCycleScrollView.h"
#import "HXRecommendTeacherCell.h"
#import "HJHomePageHeaderView.h"
#import "HXSectionHead.h"
#import "HXSearchView.h"
#import <BlocksKit/A2DynamicDelegate.h>
#import "HXSubjectVideoCell.h"
#import "HXSubjectVideoVC.h"

@interface HXHomePageTVC ()<SDCycleScrollViewDelegate>

@end

@implementation HXHomePageTVC

-(instancetype)init {

    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
  [super viewDidLoad];
    
    
    [self.navigationController setNavigationBarHidden:YES];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = KVCBackGroundColor ;
    self.tableView.tableHeaderView = [[HJHomePageHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(152))];
    
    NSArray *titles = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    BOOL objs = [titles bk_all:^BOOL(id obj) {
        
        return [obj intValue] > 2;
        
   }];
    NSLog(@"objs:%d",objs);
    [self bk_performBlock:^(id obj) {
        
        NSLog(@"perform:%@",((HXHomePageTVC *)obj).view);
        
    } afterDelay:3];
    self.tableView.backgroundColor = kWhiteColor;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    if (section == 0) {
        return 2;
    }else {
        return 1;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    if (indexPath.section == 0) {
        
        HXRecommendTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXRecommendTeacherCell"];
        if (cell == nil) {
            cell = [HXRecommendTeacherCell initTeacherCellWithXib];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 1){
        
       HXSubjectVideoCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"HXSubjectVideoCell"];
        if (cell == nil) {
            cell = [[HXSubjectVideoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HXSubjectVideoCell"];

        }
        cell.nav = self.navigationController;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:
            return WidthScaleSize_H(100);
            break;
        case 1:
            return 350;
            break;
        default:

            break;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return WidthScaleSize_H(40);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return  0.01;
 
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
//    //changeBtn 右边按钮
    ContentType contentType;
    NSString *imageName;
    NSString *titleName;
    NSString *headTitle;

    if (section == 0) {
        headTitle = @"  名师推荐";
        contentType = LeftImageRightTitle;
        imageName = @"change";
        titleName = @"换一换";
    }
    
    if (section == 1) {
        headTitle = @"  专题视频";
        contentType = LeftImageRightTitle;
        imageName = @"";
        titleName = @"更多》";

    }

       HXSectionHead *sectionHead = [[[HXSectionHead alloc] init] createSectionHeadWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(35)) section:(NSInteger)section headTitle:headTitle discrib:@"为你的梦想保驾护航" contenType:contentType rightBtnTitle:titleName imageName:imageName labFont:FONT(14) buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:FontLightGrayColor fontsize:14]];
      [sectionHead setTapActionWithBlock:^{
          [self rightBtnActionWithSection:section];
      }];

    return sectionHead;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 4) {
        
        
    }

}
#pragma mark --- sectionHead delegate

- (void)rightBtnActionWithSection:(NSInteger)section {

    NSLog(@"section:%ld",section);
    if (section == 1) {
        
        HXSubjectVideoVC *vc = [HXSubjectVideoVC new];
        
        [self.navigationController pushVC:vc];
        }

}


@end
