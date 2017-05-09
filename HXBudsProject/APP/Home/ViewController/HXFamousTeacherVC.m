//
//  HXFamousTeacherVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXFamousTeacherVC.h"
#import "HXOrganizationCell.h"
#import "HXOrganizationDetailVC.h"
@interface HXFamousTeacherVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)   UITableView *teacherListTable;

@end

@implementation HXFamousTeacherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐机构";
    
    //tableView
    self.teacherListTable = [[UITableView alloc]initWithFrame:CGRectMake(0,WidthScaleSize_H(44), SCREEN_WIDTH, SCREEN_HEIGHT- 64 - WidthScaleSize_H(44)) style:UITableViewStylePlain];
    self.teacherListTable.delegate = self;
    self.teacherListTable.dataSource = self;
    self.teacherListTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.teacherListTable];
    
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
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HXOrganizationDetailVC *detailVC = [[HXOrganizationDetailVC alloc]init];
    detailVC.detailType = teacherDetailType;

    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

@end
