//
//  PGIndexBannerSubiew.m
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//  Designed By PageGuo,
//  QQ:799573715
//  github:https://github.com/PageGuo/NewPagedFlowView

#import "PGIndexBannerSubiew.h"

@implementation PGIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.mainImageView];
        [self addSubview:self.coverView];
        [self.mainImageView addSubview:self.bottomV];
        [self.mainImageView addSubview:self.tagImageView];
        [self.mainImageView addSubview:self.courseLab];
        [self.mainImageView addSubview:self.teacherLab];
        [self.mainImageView addSubview:self.priceLab];
        
        
    }
    
    return self;
}

- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
        _coverView.backgroundColor = [UIColor grayColor];
    }
    return _coverView;
}

- (UIView *)bottomV {

    if (_bottomV == nil) {
        _bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, _mainImageView.frame.size.height - 48, _mainImageView.frame.size.width, 48)];
        _bottomV.backgroundColor = [UIColor redColor];
        _bottomV.alpha = 0.15;
        
    }
    return _bottomV;

}

- (UIImageView *)tagImageView {

    if (_tagImageView == nil) {
        _tagImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, -5, 25, 38)];
        _tagImageView.image = [UIImage imageNamed:@"new"];
        _tagImageView.contentMode = UIViewContentModeCenter;
    }
    return _tagImageView;
}
- (UILabel *)courseLab {

    if (_courseLab == nil) {
        _courseLab = [[UILabel alloc]initWithFrame:CGRectMake(10, -5, 25, 38)];
    }
    return _courseLab;

}

- (UILabel *)teacherLab {

    if (_teacherLab == nil) {
        _teacherLab =  [[UILabel alloc]initWithFrame:CGRectMake(10, -5, 25, 38)];

    }
    return _teacherLab;

}
- (UILabel *)priceLab {
    
    if (_priceLab == nil) {
        _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(10, -5, 25, 38)];
        


    }
    return _priceLab;

}
@end
