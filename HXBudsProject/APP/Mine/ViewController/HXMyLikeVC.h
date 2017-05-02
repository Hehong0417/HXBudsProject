//
//  HXMyLikeVC.h
//  HXBudsProject
//
//  Created by n on 2017/3/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DynamicType) {
    teacherDynamicType,//名师
    himDynamicType,//用户
    mineDynamicType,//我
};

@interface HXMyLikeVC : UIViewController

@property(nonatomic,copy) NSString *titleStr;

@property(nonatomic,copy) NSString *theteacher_id;

@property(nonatomic,copy) NSString *users_id;

@property(nonatomic,assign) DynamicType dynamicType;


@end
