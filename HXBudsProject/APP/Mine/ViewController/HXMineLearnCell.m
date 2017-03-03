//
//  HXMineLearnCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMineLearnCell.h"

@implementation HXMineLearnCell


+ (instancetype)initMineCellWithXib{

 
    return [[[NSBundle mainBundle]loadNibNamed:@"HXMineLearnCell" owner:nil options:nil] lastObject];

}
- (void)awakeFromNib{

    [super awakeFromNib];
    self.leftBtn.adjustsImageWhenHighlighted = NO;
    self.rightBtn.adjustsImageWhenHighlighted = NO;
    
}
- (void)setLeftImageStr:(NSString *)leftImageStr {

    _leftImageStr = leftImageStr;
    
    [self.leftBtn setImage:[UIImage imageNamed:self.leftImageStr] forState:UIControlStateNormal];

}
- (void)setRightImageStr:(NSString *)rightImageStr {

    _rightImageStr = rightImageStr;
    [self.rightBtn setImage:[UIImage imageNamed:self.rightImageStr] forState:UIControlStateNormal];

}

@end
