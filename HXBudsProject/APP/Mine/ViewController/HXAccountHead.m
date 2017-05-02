//
//  HXAccountHead.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXAccountHead.h"
#import "HXBalanceRechargeVC.h"

@implementation HXAccountHead

- (instancetype)initWithFrame:(CGRect)frame {


    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.balanceLabel];
        [self addSubview:self.balanceRechargeBgView];
        [self.balanceRechargeBgView addSubview:self.rightImageView];
        [self.balanceRechargeBgView addSubview:self.balanceRechargeLabel];

        [self makeContriant];
    }

    return self;
}
- (void)makeContriant {

   [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      
       make.left.mas_offset(20);
       make.top.mas_offset(0);
       make.height.mas_equalTo(40);
       make.right.equalTo(self);
       
   }];
  [self.balanceLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
     
      make.left.equalTo(self.titleLabel);
      make.top.equalTo(self.titleLabel.mas_bottom).with.offset(0);
      make.height.mas_equalTo(70);
      make.width.mas_equalTo(320);
      
  }];
    [self.balanceRechargeBgView  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(50);
        
    }];
    
    [self.balanceRechargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.top.mas_offset(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(150);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self);
        make.top.mas_offset(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);

    }];
}


- (UILabel *)titleLabel {

    if (!_titleLabel) {
        _titleLabel = [UILabel lh_labelWithFrame:CGRectZero text:@"账户余额（元）" textColor:kWhiteColor font:FONT(14) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    }

    return _titleLabel;
}
- (UILabel *)balanceLabel {
    
    if (!_balanceLabel) {
        _balanceLabel= [UILabel lh_labelWithFrame:CGRectZero text:@"190.00" textColor:kWhiteColor font:FONT(50) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    }
    
    return _balanceLabel;
}


- (UILabel *)balanceRechargeLabel {

    if (!_balanceRechargeLabel) {
        _balanceRechargeLabel= [UILabel lh_labelWithFrame:CGRectZero text:@"余额提现(100元起提现)" textColor:kWhiteColor font:FONT(14) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    }
    
    return _balanceRechargeLabel;
}



- (UIView *)balanceRechargeBgView{

    if (!_balanceRechargeBgView) {
        _balanceRechargeBgView= [[UIView alloc] init];
        _balanceRechargeBgView.backgroundColor = [UIColor colorWithHexString:@"#00AEA7"];
    }
    
    return _balanceRechargeBgView;

}

- (UIImageView *)rightImageView{

    if (!_rightImageView) {
        _rightImageView= [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"white_arrow"];
        _rightImageView.contentMode = UIViewContentModeCenter;
    }
    
    return _rightImageView;


}
@end
