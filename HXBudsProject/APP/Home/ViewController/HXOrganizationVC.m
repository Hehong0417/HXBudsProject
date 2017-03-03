//
//  HXOrganizationVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationVC.h"
#import "HXTeacherBannerView.h"
#import "HXOrganizationCell.h"
#import "HXOrganizationDetailTVC.h"


@interface HXOrganizationVC ()<UITableViewDelegate,UITableViewDataSource,HXTeacherBannerDelegate>

@property (nonatomic, strong)   UITableView *teacherListTable;

@end

@implementation HXOrganizationVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"机构列表";

    //bannerView
    HXTeacherBannerView *bannerView = [HXTeacherBannerView initTeacherBannerViewWithXib];
    
    bannerView.frame = CGRectMake(0,0, SCREEN_WIDTH, WidthScaleSize_H(44));
    bannerView.delegate = self;
    [bannerView.btn1 setTitle:@"距离由近到远" forState:0];
    [bannerView.btn2 setTitle:@"人气由高到低" forState:0];
    UIView *view = [UIView lh_viewWithFrame:CGRectMake(0,0, SCREEN_WIDTH, WidthScaleSize_H(44)) backColor:kWhiteColor];
    [view addSubview:bannerView];
    [self.view addSubview:view];
    
    if (self.isMyLike) {
        
        bannerView.hidden = YES;
    }else {
    
        bannerView.hidden = NO;
    }
    
    
    //tableView
    self.teacherListTable = [[UITableView alloc]initWithFrame:CGRectMake(0,WidthScaleSize_H(44), SCREEN_WIDTH, SCREEN_HEIGHT- 64 - WidthScaleSize_H(44)) style:UITableViewStylePlain];
    self.teacherListTable.delegate = self;
    self.teacherListTable.dataSource = self;
    self.teacherListTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.teacherListTable];
    
}

#pragma mark --- bannerView delegate

- (void)buttonClickWithIndex:(NSInteger)index {
    
    if (index == 1) {
        
        NSLog(@"距离排序");
        
    }else if(index == 2){
        
        NSLog(@"人气排序");
    }    
    
}


#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXOrganizationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXOrganizationCell"];
    if (cell == nil) {
        cell = [HXOrganizationCell initOrganizationCellWithXib];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return WidthScaleSize_H(140);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


    HXOrganizationDetailTVC *detailVC = [[HXOrganizationDetailTVC alloc]init];
    
    [self.navigationController pushViewController:detailVC animated:YES];


}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {


    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01;
    
}
@end
