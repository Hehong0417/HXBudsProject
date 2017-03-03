//
//  HXOrganizationDetailTVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationDetailTVC.h"
#import "HXYourLikeCell.h"
#import "HXHomePerformanceActivityCell.h"
#import "HXOrganizationHeadView.h"
#import "HXSectionHead.h"
#import "HXTeacherListVC.h"

@interface HXOrganizationDetailTVC ()<HXSectionHeadDalegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation HXOrganizationDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.title = @"机构主页";
//
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = KVCBackGroundColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT+20) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    
    HXOrganizationHeadView *head =  [HXOrganizationHeadView initOrganizationHeadViewWithXib];
    head.frame = CGRectMake(0, -20, SCREEN_WIDTH, WidthScaleSize_H(150));
    [head.backBtn setTapActionWithBlock:^{
       
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    self.tableView.tableHeaderView = head;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return WidthScaleSize_H(0.01);

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return WidthScaleSize_H(30);

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *headTitle;
    ContentType contentType;
    NSString *rightBtnTitle;
    NSString *imageName;
    
    if (section == 0) {
        headTitle = @"";
        contentType = LeftTitleRightImage;
        rightBtnTitle = @"显示全部";
        imageName = @"rightArrow";
    }else if(section == 1){
        headTitle = @"  机构老师";
        contentType = LeftTitleRightImage;
        rightBtnTitle = @"显示全部";
        imageName = @"rightArrow";
    }else{
    
        headTitle = @"  机构简介";
        contentType = LeftTitleRightImage;
        rightBtnTitle = @"";
        imageName = @"";
    
    }
    
    HXSectionHead *sectionHead = [[[HXSectionHead alloc]init]createSectionHeadWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(30)) section:section headTitle:headTitle contenType:contentType rightBtnTitle:rightBtnTitle imageName:imageName labFont:FONT(18) buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:FontLightGrayColor fontsize:12]];
    sectionHead.delegate = self;
    
    return sectionHead;
    
}
#pragma mark --- sectionHead delegate

- (void)rightBtnActionWithSection:(NSInteger)section {

    if (section == 0) {
        NSLog(@"%ld",section);
    }
    if (section == 1) {
        
        HXTeacherListVC *teacherListVC = [HXTeacherListVC new];
        
        [self.navigationController pushVC:teacherListVC];
    }
}

#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:{
            HXYourLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXYourLikeCell"];
            if (!cell) {
                cell = [[HXYourLikeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HXYourLikeCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:{
            HXHomePerformanceActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXHomePerformanceActivityCell"];
            if (!cell) {
                cell = [[HXHomePerformanceActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HXHomePerformanceActivityCell"];
            }
            
            NSArray *dataArr = @[@"01",@"02",@"03",@"04",@"05"];
            [cell setDataArr:dataArr rowMargin:WidthScaleSize_H(20) imageV_W:WidthScaleSize_W(60) imagV_H:WidthScaleSize_W(60) radius:WidthScaleSize_W(60)/2 textColor:APP_COMMON_COLOR font:FONT(10)];
            return cell;
        }
            break;
        case 2:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXHomePerformanceActivityCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.textLabel.text = @"机构简介内容机构简介内容机构简介内容机构简介内容机构简介内容机构简介内容机构简介内容机构简介内容机构简介内容机构简介内容机构简介内容机构简介内容机构简介内容机构简介内容机构简介内容机构简介内容";
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = FONT(13);
            return cell;
            
        }
            break;
    
        default:
            break;
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:{
                    
            return WidthScaleSize_H(230);
        }
            break;
        case 1:{
            
            return WidthScaleSize_H(120);
        }
            break;
        case 2:{
            return WidthScaleSize_H(100);
        }
            break;
            
        default:
            break;
    }
    
    return 0.01;


}
@end
