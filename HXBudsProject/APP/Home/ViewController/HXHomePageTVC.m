//
//  HXHomePageTVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/7.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXHomePageTVC.h"
#import "HXTeacherListVC.h"
#import "SDCycleScrollView.h"
#import "HXRecommendTeacherCell.h"
#import "HXHomePerformanceActivityCell.h"
#import "HJHomePageHeaderView.h"
#import "HXModuleListCell.h"
#import "HXHomeCourseCell.h"
#import "HXOrganizationVC.h"
#import "HXActinityVC.h"
#import "HXCourseListVC.h"
#import "HXArtTestInformationCell.h"
#import "HXYourLikeCell.h"
#import "HXSectionHead.h"
#import "HXSearchView.h"
#import "HXInformationTVC.h"
#import "HXCourseClassifyVC.h"
#import <BlocksKit/A2DynamicDelegate.h>
#import "HXInformationDetailVC.h"


@interface HXHomePageTVC ()<SDCycleScrollViewDelegate,HXModuleListDelegate,HXSectionHeadDalegate,HXHomePerformanceCellDelegate>

@end

@implementation HXHomePageTVC

-(instancetype)init {

    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
  [super viewDidLoad];
    
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
    XYQButton *locateBtn = [XYQButton ButtonWithFrame:CGRectMake(20, 4, 44, 60) imgaeName:@"locate" titleName:@"番禺区" contentType:TopTitleBottomImage buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kWhiteColor fontsize:14] tapAction:^(XYQButton *button) {
        
    }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:locateBtn];
    
    UIImageView *search_box = [UIImageView lh_imageViewWithFrame:CGRectMake(0, 0, WidthScaleSize_W(250), 30) image:[UIImage imageNamed:@"search_box"]];
    UIImageView *search_l = [UIImageView lh_imageViewWithFrame:CGRectMake(10, 0, WidthScaleSize_W(30), 30) image:[UIImage imageNamed:@"search_L"]];
    search_box.userInteractionEnabled = YES;
    search_l.contentMode = UIViewContentModeCenter;
    search_l.centerY = search_box.centerY;
    [search_box addSubview:search_l];
    
    
    UITextField *searchText = [[UITextField alloc]initWithFrame:CGRectMake(20+WidthScaleSize_W(18), 0, WidthScaleSize_W(250) - 30 - WidthScaleSize_W(18), 30)];
    searchText.font = FONT(14);
    searchText.textAlignment = NSTextAlignmentLeft;
    UIColor *fontNameColor = [UIColor colorWithHexString:@"#69C6B6"];
    NSAttributedString *attributePlaceholder = [[NSAttributedString alloc]initWithString:@"想学什么" attributes:@{NSForegroundColorAttributeName:fontNameColor}];
    searchText.attributedPlaceholder = attributePlaceholder;
    [search_box addSubview:searchText];
    searchText.enabled = NO;
    
    [search_box setTapActionWithBlock:^{
       
        HXSearchView *searchView = [[HXSearchView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [searchView showAnimated:NO];
    }];
    
    
    self.navigationItem.titleView = search_box;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = KVCBackGroundColor ;
    self.tableView.tableHeaderView = [[HJHomePageHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(200))];
    
    NSArray *titles = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    BOOL objs = [titles bk_all:^BOOL(id obj) {
        
        return [obj intValue] > 2;
        
   }];
    NSLog(@"objs:%d",objs);
    [self bk_performBlock:^(id obj) {
        
        NSLog(@"perform:%@",((HXHomePageTVC *)obj).view);
        
    } afterDelay:3];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0||section == 1||section == 3||section == 5) {
        return 1;
    }
    if (section == 4) {
        return 4;
    }

    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    if (indexPath.section == 0) {
        
        HXModuleListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXModuleListCell"];
        if (cell == nil) {
            cell = [[HXModuleListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HXModuleListCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
        
    }else if (indexPath.section == 1){
        
        HXHomeCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXHomeCourseCell"];
        if (cell == nil) {
            cell = [[HXHomeCourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HXHomeCourseCell"];

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.vc = self.navigationController;
        return cell;
        
    }else if (indexPath.section == 2) {
        //名师推荐
        HXRecommendTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXRecommendTeacherCell"];
        if (cell == nil) {
            cell = [HXRecommendTeacherCell initTeacherCellWithXib];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
    }else if(indexPath.section == 3){
        //演出活动
        HXHomePerformanceActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXHomePerformanceActivityCell" ];
        if (!cell) {
            cell = [[HXHomePerformanceActivityCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HXHomePerformanceActivityCell"];
        }
        NSArray *dataArr = @[@"01",@"02",@"03"];
        [cell   setDataArr:dataArr rowMargin:WidthScaleSize_W(20) imageV_W:WidthScaleSize_W(176) imagV_H:WidthScaleSize_H(120) radius:8 textColor:FontGrayColor font:FONT(14)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else if(indexPath.section == 4){
       //艺考资讯
        HXArtTestInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXArtTestInformationCell"];
        
        if (!cell) {
            cell = [HXArtTestInformationCell initWithArtTestInformationXib];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
    }else if(indexPath.section == 5){
        //艺考资讯
        HXYourLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXYourLikeCell"];
        
        if (!cell) {
            cell = [[HXYourLikeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HXYourLikeCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    switch (indexPath.section) {
        case 0:
            return WidthScaleSize_H(60);
            break;
        case 1:
            return WidthScaleSize_H(200);
            break;
        case 2:
            return WidthScaleSize_H(100);
            break;
        case 3:
            return WidthScaleSize_H(180);
            break;
        case 4:
            return WidthScaleSize_H(44);
            break;
        default:
            return WidthScaleSize_H(240);
            break;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 ||section == 1) {
        return  0.01;
    }
    return WidthScaleSize_H(35);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return  10;
 
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0 ||section == 1) {
        return  nil;
    }
//    
//    //changeBtn 右边按钮
    ContentType contentType;
    NSString *imageName;
    NSString *titleName;
    NSString *headTitle;

    if (section == 2) {
        headTitle = @"  名师推荐";
        contentType = LeftImageRightTitle;
        imageName = @"change";
        titleName = @"换一换";
    }
    
    if (section == 3) {
        headTitle = @"  演出活动";
        contentType = LeftImageRightTitle;
        imageName = @"change";
        titleName = @"换一换";

    }
    //艺考资讯
    if (section == 4) {
        headTitle = @"  艺考资讯";
        contentType = LeftTitleRightImage;
        imageName = @"ic_list_xiangqing";
        titleName = @"查看全部";

    }
    //猜你喜欢
    if (section == 5) {
        headTitle = @"  猜你喜欢";
        contentType = LeftImageRightTitle;
        imageName = @"change";
        titleName = @"换一换";
    }
       HXSectionHead *sectionHead = [[[HXSectionHead alloc] init] createSectionHeadWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(35)) section:(NSInteger)section headTitle:headTitle contenType:contentType rightBtnTitle:titleName imageName:imageName labFont:FONT(18) buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:FontLightGrayColor fontsize:14]];
    
        sectionHead.delegate = self;

    return sectionHead;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 4) {
        
        HXInformationDetailVC *detailVc = [HXInformationDetailVC new];
        [self.navigationController pushVC:detailVc];
        
    }

}
#pragma mark --- sectionHead delegate

- (void)rightBtnActionWithSection:(NSInteger)section {

    NSLog(@"section:%ld",section);
    if (section == 4) {
        HXInformationTVC *vc = [HXInformationTVC new];
        [self.navigationController pushVC:vc];
    }

}

#pragma mark --- performanceCell  delegate

- (void)selectImageWithIndex:(NSInteger)index {

    NSLog(@"点击了第%ld张图",index);

}

#pragma mark --- moduleListCell delegate

- (void)btnClickWithIndex:(NSInteger)index {

    if (index == 1) {
       //精品课程
        HXCourseClassifyVC *classVC = [HXCourseClassifyVC new];
        
        [self.navigationController pushVC:classVC];
    //
        
    }else if(index == 2){
       //名师机构
        HXOrganizationVC *vc = [[HXOrganizationVC alloc]init];
        [self.navigationController pushVC:vc];
        
    }else if(index == 3){
        //演出活动
        HXActinityVC *vc = [[HXActinityVC alloc]init];
        vc.isHomeEntrance = YES;
        [self.navigationController pushVC:vc];
        
    }else if(index == 4){
        //艺术考试
        HXInformationTVC *vc = [HXInformationTVC new];
        [self.navigationController pushVC:vc];
        
    }

}
@end
