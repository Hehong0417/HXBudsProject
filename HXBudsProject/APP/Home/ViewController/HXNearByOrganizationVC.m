//
//  HXNearByOrganizationVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/17.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXNearByOrganizationVC.h"
#import "HXOrganizationCell.h"
#import "HXOrganizationDetailVC.h"
#import "HXLoginVC.h"
#import "HXOrganizationListAPI.h"
#import "HXOrganizationListModel.h"

@interface HXNearByOrganizationVC ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate>{
   BMKLocationService *_locService;
}
@property (nonatomic, strong)   UITableView *organizationListTable;
@property (nonatomic, strong)   HXOrganizationListModel *OrganizationListModel;
@property (nonatomic, strong)   BMKUserLocation *userLocation;
@property (nonatomic, strong)   NSMutableArray *nearByArr;
@property (nonatomic, strong)   NSMutableArray *sortedArray;

@end

@implementation HXNearByOrganizationVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //地图定位
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    [self getOrganizationListData];

}
- (NSMutableArray *)nearByArr{
    if (!_nearByArr) {
        _nearByArr = [NSMutableArray array];
    }
    return _nearByArr;
}
- (NSMutableArray *)sortedArray {

    if (!_sortedArray) {
        _sortedArray = [NSMutableArray array];
    }
    return _sortedArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"附近机构";
    
    //tableView
    self.organizationListTable = [[UITableView alloc]initWithFrame:CGRectMake(0,WidthScaleSize_H(44), SCREEN_WIDTH, SCREEN_HEIGHT- 64 - WidthScaleSize_H(44)) style:UITableViewStylePlain];
    self.organizationListTable.delegate = self;
    self.organizationListTable.dataSource = self;
    self.organizationListTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.organizationListTable];
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

- (void)getOrganizationListData{
    [self.sortedArray removeAllObjects];
    [self.nearByArr removeAllObjects];
    [[[HXOrganizationListAPI getOrganizationListWithmechanism_id:nil Limit:@"30" recommend:nil] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        
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

            [self.nearByArr addObject:vModel];
        }
       NSArray *sortArr = [self.nearByArr sortedArrayUsingComparator:^NSComparisonResult( HXOrganizationVarListModel *obj1,HXOrganizationVarListModel *obj2) {
           NSNumber *tNumber1 = (NSNumber *)obj1.distance;
           NSNumber *tNumber2 = (NSNumber *)obj2.distance;
           //因为满足sortedArrayUsingComparator方法的默认排序顺序，则不需要交换
           if ([tNumber1 integerValue] < [tNumber2 integerValue])
               return NSOrderedAscending;
           return NSOrderedDescending;
        }];
        [self.sortedArray addObjectsFromArray:sortArr];
        NSLog(@"sortArr---%@",self.sortedArray);

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
//    NSArray *arr = self.sortedArray[0];
    HXOrganizationVarListModel *model = self.sortedArray[indexPath.row];
    cell.organizationModel = model;
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    NSArray *arr = self.sortedArray[0];
    return self.sortedArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return WidthScaleSize_H(95);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXOrganizationDetailVC *vc = [[HXOrganizationDetailVC alloc]init];
    vc.detailType = organizationType;
//     NSArray *arr = self.sortedArray[0];
    HXOrganizationVarListModel *model = self.sortedArray[indexPath.row];
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
