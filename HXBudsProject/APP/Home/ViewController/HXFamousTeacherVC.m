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
    
    BMKLocationService *_locService;
}
@property (nonatomic, strong)   BMKUserLocation *userLocation;
@property (nonatomic, strong)   UITableView *teacherListTable;
@property (nonatomic, strong)   HXTeacherListModel *teacherListModel;
@property (nonatomic, strong)   NSMutableArray *recommonedArr;

@end

@implementation HXFamousTeacherVC

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getTeacherListState:self.typeNum];
    
    
    
}
- (NSMutableArray *)recommonedArr {
    
    if (!_recommonedArr) {
        _recommonedArr = [NSMutableArray array];
    }
    return _recommonedArr;
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
//    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.userLocation = userLocation;
}
- (void)getTeacherListState:(NSInteger)State{
    
    
    NSString *recommend;
    if (State == 1) {
        //推荐机构
        recommend = @"curriculum-recommend-tj";
    }else if (State == 2){
        //全部
        recommend = nil;
    }
    
    [[[HXTeacherListAPI getTeacherListWithWithLimit:@20 State:recommend] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        
        HXTeacherListModel *api = [HXTeacherListModel new];
        
        self.teacherListModel = [api.class mj_objectWithKeyValues:responseObject];
        
        for (HXteacherVarListModel *model in self.teacherListModel.varList) {
            
            HXteacherVarListModel *vModel = [HXteacherVarListModel new];
            CLLocationCoordinate2D coor2;
            //            coor2.latitude = 39.90868;
            //            coor2.longitude = 116.3956;
            coor2.latitude = self.userLocation.location.coordinate.latitude;
            coor2.longitude = self.userLocation.location.coordinate.longitude;
            BMKMapPoint point1 = BMKMapPointForCoordinate(coor2);
            BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(model.lat.floatValue,model.lng.floatValue));
            CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
            vModel.theteacher_id = model.theteacher_id;
            vModel.hobby = model.hobby;
            vModel.the_headportrait = model.the_headportrait;
            vModel.the_name = model.the_name;
            vModel.distance = [NSString stringWithFormat:@"%.0f",distance];
            NSLog(@"distance---%@",vModel.distance);
            NSLog(@"userLocation---%.2f----%.2f",self.userLocation.location.coordinate.latitude,self.userLocation.location.coordinate.longitude);
            NSLog(@"mechanismLocation---%.2f----%.2f",model.lat.floatValue,model.lng.floatValue);
            
            [self.recommonedArr addObject:vModel];
        }
        
        [self.teacherListTable reloadData];
        
    }];
}

#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXOrganizationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXOrganizationCell"];
    if (cell == nil) {
        cell = [HXOrganizationCell initOrganizationCellWithXib];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.teacherModel = self.recommonedArr[indexPath.row];

    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
  return self.recommonedArr.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HXOrganizationDetailVC *detailVC = [[HXOrganizationDetailVC alloc]init];
    HXteacherVarListModel *model = self.recommonedArr[indexPath.row];
    detailVC.teacher_Id = model.theteacher_id;
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
