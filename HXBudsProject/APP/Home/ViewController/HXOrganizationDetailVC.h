//
//  HXOrganizationDetailVC.h
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HXOrganizationDetailVC : UIViewController

@property(nonatomic,assign) DetailType detailType;

@property(nonatomic,strong) NSString *organization_Id;

@property(nonatomic,strong) NSString *teacher_Id;

@property(nonatomic,assign) BOOL isLogin;


@end
