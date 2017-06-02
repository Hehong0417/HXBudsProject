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

@interface HXOrganizationVC ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate>{
    BMKLocationService *_locService;
}
@property (nonatomic, strong)   UITableView *organizationListTable;
@property (nonatomic, strong)   HXOrganizationListModel *OrganizationListModel;
@property (nonatomic, strong)   BMKUserLocation *userLocation;
@property (nonatomic, strong)   NSMutableArray *recommonedArr;
@end

@implementation HXOrganizationVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

    [self getOrganizationListDataWithState:self.typeNum];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    
    //启动LocationService
    [_locService startUserLocationService];
    
    self.title = @"推荐机构";
    [self getOrganizationListDataWithState:self.typeNum];

    //tableView
    self.organizationListTable = [[UITableView alloc]initWithFrame:CGRectMake(0,WidthScaleSize_H(44), SCREEN_WIDTH, SCREEN_HEIGHT- 64 - WidthScaleSize_H(44)) style:UITableViewStylePlain];
    self.organizationListTable.delegate = self;
    self.organizationListTable.dataSource = self;
    self.organizationListTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.organizationListTable];
    
}
- (NSMutableArray *)recommonedArr {
    
    if (!_recommonedArr) {
        _recommonedArr = [NSMutableArray array];
    }
    return _recommonedArr;
}
#pragma mark - 实现相关delegate 处理位置信息更新

//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
//        NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//        NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.userLocation = userLocation;
}
- (void)getOrganizationListDataWithState:(NSInteger)State {
    
    
    NSString *recommend;
    if (State == 1) {
       //推荐机构
        recommend = @"curriculum-recommend-tj";
    }else if (State == 2){
    //全部
        recommend = nil;
    }
    
  [[[HXOrganizationListAPI getOrganizationListWithmechanism_id:nil Limit:@"30" recommend:recommend] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
      if (error==nil) {
      HXOrganizationListModel *api = [HXOrganizationListModel new];
      self.OrganizationListModel = [api.class mj_objectWithKeyValues:responseObject];
      for (HXOrganizationVarListModel *model in self.OrganizationListModel.varList) {
          
          HXOrganizationVarListModel *vModel = [HXOrganizationVarListModel new];
          CLLocationCoordinate2D coor2;
          //            coor2.latitude = 39.90868;
          //            coor2.longitude = 116.3956;
          coor2.latitude = self.userLocation.location.coordinate.latitude;
          coor2.longitude = self.userLocation.location.coordinate.longitude;
          BMKMapPoint point1 = BMKMapPointForCoordinate(coor2);
          BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(model.mechanism_lat.floatValue,model.mechanism_lng.floatValue));
          CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
          vModel.mechanism_id = model.mechanism_id;
          vModel.mechanism_desc = model.mechanism_desc;
          vModel.mechanism_logo = model.mechanism_logo;
          vModel.mechanism_name = model.mechanism_name;
          vModel.mechanism_address = model.mechanism_address;
          vModel.distance = [NSString stringWithFormat:@"%.0f",distance];
          NSLog(@"distance---%@",vModel.distance);
          NSLog(@"userLocation---%.2f----%.2f",self.userLocation.location.coordinate.latitude,self.userLocation.location.coordinate.longitude);
          NSLog(@"mechanismLocation---%.2f----%.2f",model.mechanism_lat.floatValue,model.mechanism_lng.floatValue);
          
          [self.recommonedArr addObject:vModel];
      }
      [self.organizationListTable reloadData];
      }
  }];

}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXOrganizationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXOrganizationCell"];
    if (cell == nil) {
        cell = [HXOrganizationCell initOrganizationCellWithXib];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    HXOrganizationVarListModel *model = self.recommonedArr[indexPath.row];
    cell.organizationModel = model;
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.recommonedArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return WidthScaleSize_H(95);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    HXOrganizationDetailVC *vc = [[HXOrganizationDetailVC alloc]init];
    vc.detailType = organizationType;
    HXOrganizationVarListModel *model = self.recommonedArr[indexPath.row];
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
