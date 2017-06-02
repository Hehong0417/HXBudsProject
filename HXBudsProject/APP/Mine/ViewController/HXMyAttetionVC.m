//
//  HXMyAttetionVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyAttetionVC.h"
#import "HXMyAttentionCell.h"
#import "HXMyLikeVC.h"
#import "HXMyattetionTeacherAPI.h"
#import "HXTeacherListModel.h"
#import "HXOrganizationDetailVC.h"

@interface HXMyAttetionVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) HXTeacherListModel *teacherListModel;

@end

@implementation HXMyAttetionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self getMyattetionTeacherData];
    
    self.title = @"名师";
    switch (self.attentionType) {
        case mineType:
             self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
            break;
        case dynamicType:
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-268) style:UITableViewStyleGrouped];
        default:
            break;
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = kWhiteColor;
    
   
}
- (void)getMyattetionTeacherData {

    [[[HXMyattetionTeacherAPI getMyattetionTeacher] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        if (error==nil) {
        HXTeacherListModel *api = [HXTeacherListModel new];
        self.teacherListModel = [api.class mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.teacherListModel.varList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 104;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXMyAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXMyAttentionCell"];
    if(!cell){
        
        cell = [HXMyAttentionCell initMyAttentionCellWithXib];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.teacherListModel.varList[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXOrganizationDetailVC *detailVC = [[HXOrganizationDetailVC alloc]init];
    
    HXteacherVarListModel *model = self.teacherListModel.varList[indexPath.row];
    detailVC.teacher_Id = model.theteacher_id;
    
    [self.navigationController pushViewController:detailVC animated:YES];

}




@end
