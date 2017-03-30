//
//  HXAccountHead.h
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXAccountHead : UIView

@property(nonatomic,strong)UILabel *titleLabel;

//****余额Label******//
@property(nonatomic,strong)UILabel *balanceLabel;

@property(nonatomic,strong)UIView *balanceRechargeBgView;

@property(nonatomic,strong)UILabel *balanceRechargeLabel;

@property(nonatomic,strong)UIImageView *rightImageView;

@end
