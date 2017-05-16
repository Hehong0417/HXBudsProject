//
//  HXOrganizationVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationVC.h"
#import "HXOrganizationCell.h"
#import "HXOrganizationDetailVC.h"
#import "HXLoginVC.h"
#import "HXOrganizationListAPI.h"
#import "HXOrganizationListModel.h"

@interface HXOrganizationVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)   UITableView *organizationListTable;
@property (nonatomic, strong)   HXOrganizationListModel *OrganizationListModel;

@end

@implementation HXOrganizationVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"推荐机构";
    
    //tableView
    self.organizationListTable = [[UITableView alloc]initWithFrame:CGRectMake(0,WidthScaleSize_H(44), SCREEN_WIDTH, SCREEN_HEIGHT- 64 - WidthScaleSize_H(44)) style:UITableViewStylePlain];
    self.organizationListTable.delegate = self;
    self.organizationListTable.dataSource = self;
    self.organizationListTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.organizationListTable];
    
    [self getOrganizationListData];
    
}
- (void)getOrganizationListData{
 
  [[[HXOrganizationListAPI getOrganizationListWithmechanism_id:nil Limit:@"30"] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
      
      HXOrganizationListModel *api = [HXOrganizationListModel new];
      self.OrganizationListModel = [api.class mj_objectWithKeyValues:responseObject];
      [self.organizationListTable reloadData];
      
  }];

}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXOrganizationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXOrganizationCell"];
    if (cell == nil) {
        cell = [HXOrganizationCell initOrganizationCellWithXib];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    HXOrganizationVarListModel *model = self.OrganizationListModel.varList[indexPath.row];
    cell.organizationModel = model;
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.OrganizationListModel.varList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    HXOrganizationDetailVC *vc = [[HXOrganizationDetailVC alloc]init];
    vc.detailType = organizationType;
    HXOrganizationVarListModel *model = self.OrganizationListModel.varList[indexPath.row];
    vc.organization_Id = model.mechanism_id;
    [self.navigationController pushVC:vc];


}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {


    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01;
    
}
@end
