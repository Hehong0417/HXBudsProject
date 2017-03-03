//
//  HXActivityOneVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/21.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXActivityOneVC.h"
#import "HXPerformanceActivitiesCell.h"
#import "HXActivityDetailVC.h"


@interface HXActivityOneVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)   UITableView *teacherListTable;

@end

@implementation HXActivityOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"演出音乐会";
    
    //tableView
    self.teacherListTable = [[UITableView alloc]initWithFrame:CGRectMake(0,44, SCREEN_WIDTH, SCREEN_HEIGHT - 108) style:UITableViewStyleGrouped];
    self.teacherListTable.delegate = self;
    self.teacherListTable.dataSource = self;
    [self.view addSubview:self.teacherListTable];
    
}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXPerformanceActivitiesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXPerformanceActivitiesCell"];
    if (cell == nil) {
        cell = [HXPerformanceActivitiesCell initActivityCellWithXib];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return WidthScaleSize_H(160);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    HXActivityDetailVC *vc = [[HXActivityDetailVC alloc]init];
    
    [self.navigationController pushVC:vc];


}

@end
