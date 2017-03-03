//
//  PGIndexBannerSubiew.h
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//  Designed By PageGuo,
//  QQ:799573715
//  github:https://github.com/PageGuo/NewPagedFlowView

/******************************
 
 可以根据自己的需要再次重写view
 
 ******************************/

#import <UIKit/UIKit.h>

@interface PGIndexBannerSubiew : UIView

/**
 *  主图
 */
@property (nonatomic, strong) UIImageView *mainImageView;

/**
 *  用来变色的view
 */
@property (nonatomic, strong) UIView *coverView;


/**
   new标签
 */
@property(nonatomic,strong) UIImageView  *tagImageView;


/**
 透明的底View
 */
@property(nonatomic,strong) UIView  *bottomV;

/**
 课程名称label
 */
@property(nonatomic,strong) UILabel  *courseLab;


/**
 主讲老师label
 */
@property(nonatomic,strong) UILabel  *teacherLab;

/**
   课程价格label
 */
@property(nonatomic,strong) UILabel  *priceLab;


@end
