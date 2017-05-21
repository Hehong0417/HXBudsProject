//
//  HXMapVC.h
//  HXBudsProject
//
//  Created by n on 2017/5/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXMapVC : UIViewController
@property(nonatomic,strong)NSString *latitude;
@property(nonatomic,strong)NSString *longitude;
@property (nonatomic, strong) BMKUserLocation *userLocation;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *name;

@end
