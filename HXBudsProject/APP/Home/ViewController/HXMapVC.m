//
//  HXMapVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMapVC.h"
#import <MapKit/MapKit.h>


@interface HXMapVC ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    
    BMKLocationService *_locService;
    BMKMapView* _mapView;
}
@property (nonatomic, strong) NSString *urlScheme;
@property (nonatomic, strong) NSString *appName;

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
    
    _mapView.zoomLevel = 17;
    
    self.view = _mapView;
    
    
//    UIButton *navigationBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 70, 60) target:self action:@selector(navigationAction) image:nil title:@"导航" titleColor:kBlueColor font:FONT(15)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:navigationBtn];
    
    //地图定位
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = self.latitude.floatValue;
    coor.longitude = self.longitude.floatValue;
    
    annotation.coordinate = coor;
//  annotation.title = self.address;
    [_mapView setCenterCoordinate:coor animated:YES];
    [_mapView addAnnotation:annotation];
    
 //添加底部视图
    UIView *bottomView  = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT  -  80-64, SCREEN_WIDTH, 80)];
    bottomView.backgroundColor = kWhiteColor;
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 125, 40)];
    titleLabel.font = FONT(14);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = self.name;
    [bottomView addSubview:titleLabel];
    //地址
    CGSize size = [self.address lh_sizeWithFont:FONT(13) constrainedToSize:CGSizeMake(SCREEN_WIDTH - 120, MAXFLOAT)];
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, SCREEN_WIDTH - 120, size.height)];
    addressLabel.numberOfLines = 2;
    addressLabel.font = FONT(13);
    addressLabel.textColor = kGrayColor;
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.text = self.address;
    [bottomView addSubview:addressLabel];
    //本机地图
    UIButton *mapBtn = [UIButton lh_buttonWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 20,90, 30) target:self action:@selector(navigationAction) image:nil title:@"本机地图" titleColor:kGrayColor font:FONT(14)];
    mapBtn.backgroundColor = KVCBackGroundColor;
    [mapBtn lh_setCornerRadius:3 borderWidth:1 borderColor:kLightGrayColor];
    [bottomView addSubview:mapBtn];
    
    [self.view addSubview:bottomView];
    
    self.urlScheme = @"demoURI://";
    self.appName = @"demoURI";
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

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
}
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        newAnnotationView.image = [UIImage imageNamed:@"add"];
        return newAnnotationView;
    }
    return nil;
}
- (void)navigationAction{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    //苹果地图
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]])
    {
    UIAlertAction *action1  = [UIAlertAction actionWithTitle:@"用iPhone自带的地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = self.latitude.floatValue;
        coordinate.longitude = self.longitude.floatValue;
         //目的地
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
        toLocation.name = self.name;
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                       MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    }];
        [alert addAction:action1];

}
    //百度地图
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
    {
        UIAlertAction *action2  = [UIAlertAction actionWithTitle:@"用百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = self.latitude.floatValue;
            coordinate.longitude = self.longitude.floatValue;
            
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=%@&mode=driving&coord_type=gcj02",coordinate.latitude, coordinate.longitude,self.name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }];
        
        [alert addAction:action2];

    }
    __block NSString *urlScheme = self.urlScheme;
    __block NSString *appName = self.appName;
    //高德地图
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = self.latitude.floatValue;
        coordinate.longitude = self.longitude.floatValue;
        
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        [alert addAction:action3];

    }
    //谷歌地图
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
    {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = self.latitude.floatValue;
        coordinate.longitude = self.longitude.floatValue;
        
        UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"谷歌地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action4];
    }
    UIAlertAction *action5  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action5];

    [self presentViewController:alert animated:YES completion:nil];

}

@end
