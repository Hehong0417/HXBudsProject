//
//  HXMapVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMapVC.h"
#import <MapKit/MapKit.h>


@interface HXMapVC ()<BMKMapViewDelegate>
{
    BMKMapView* _mapView;
   
}

@end

@implementation HXMapVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)viewDidLoad {
    [super viewDidLoad];

   self.title = @"地址";
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    _mapView.zoomLevel = 16;
    
    UIButton *navigationBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 70, 60) target:self action:@selector(navigationAction) image:nil title:@"导航" titleColor:kBlueColor font:FONT(15)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:navigationBtn];
    self.view = _mapView;
    
    
}
- (void) viewDidAppear:(BOOL)animated {
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = self.userLocation.location.coordinate.latitude;
    coor.longitude = self.userLocation.location.coordinate.longitude;
    annotation.coordinate = coor;
    annotation.title = @"这里是我的地盘";

    [_mapView setCenterCoordinate:coor animated:YES];
    [_mapView addAnnotation:annotation];
}
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}
- (void)navigationAction{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1  = [UIAlertAction actionWithTitle:@"用iPhone自带的地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = self.userLocation.location.coordinate.latitude;
        coordinate.longitude = self.userLocation.location.coordinate.longitude;
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                       MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    }];
    UIAlertAction *action2  = [UIAlertAction actionWithTitle:@"用百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = self.userLocation.location.coordinate.latitude-1;
        coordinate.longitude = self.userLocation.location.coordinate.longitude-1;
        
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",self.userLocation.location.coordinate.latitude,self.userLocation.location.coordinate.longitude,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }];
    UIAlertAction *action3  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];

    [self presentViewController:alert animated:YES completion:nil];

}

@end
