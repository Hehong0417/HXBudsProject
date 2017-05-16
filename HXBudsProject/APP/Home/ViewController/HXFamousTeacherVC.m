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
#import "HXTeacherListAPI.h"
#import "HXIsLoginAPI.h"
#import "HXTeacherListModel.h"


@interface HXFamousTeacherVC ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate>
{
    
    BOOL isLogin;
    BMKLocationService *_locService;
}
@property (nonatomic, strong)   UITableView *teacherListTable;
@property (nonatomic, strong) HXTeacherListModel *teacherListModel;

@end

@implementation HXFamousTeacherVC

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getTeacherList];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐名师";
    
    //tableView
    self.teacherListTable = [[UITableView alloc]initWithFrame:CGRectMake(0,WidthScaleSize_H(44), SCREEN_WIDTH, SCREEN_HEIGHT- 64 - WidthScaleSize_H(44)) style:UITableViewStylePlain];
    self.teacherListTable.delegate = self;
    self.teacherListTable.dataSource = self;
    self.teacherListTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.teacherListTable];
    
    
    //地图定位
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    
}
#pragma mark - 实现相关delegate 处理位置信息更新

//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}
- (void)getTeacherList{
    
    //判断是否登录
    HJUser *user = [HJUser sharedUser];
    [[[HXIsLoginAPI isLoginWithToken:user.pd.token] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        if (error) {
            isLogin = NO;
        }
        NSString *isLoginStr = responseObject[@"pd"][@"islogin"];
        if ([isLoginStr isEqualToString:@"no"]) {
            isLogin = NO;
        }else {
            isLogin = YES;
        }
        
        [[[HXTeacherListAPI getTeacherListWithWithLimit:@10 isLogin:isLogin] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
            
            HXTeacherListModel *api = [HXTeacherListModel new];
            
            self.teacherListModel = [api.class mj_objectWithKeyValues:responseObject];
            
            [self.teacherListTable reloadData];
            
        }];
        
    }];
}

#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXOrganizationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXOrganizationCell"];
    if (cell == nil) {
        cell = [HXOrganizationCell initOrganizationCellWithXib];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.teacherModel = self.teacherListModel.varList[indexPath.row];

    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
  return self.teacherListModel.varList.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HXOrganizationDetailVC *detailVC = [[HXOrganizationDetailVC alloc]init];
    HXteacherVarListModel *model = self.teacherListModel.varList[indexPath.row];
    detailVC.teacher_Id = model.theteacher_id;
    detailVC.isLogin = isLogin;
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
