//
//  HXMyAttetionVC.h
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, AttentionType) {
    dynamicType,//动态类型
    mineType,//我的类型
};


@interface HXMyAttetionVC : UIViewController

@property(nonatomic,assign) AttentionType attentionType;

@end
