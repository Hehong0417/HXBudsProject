
//
//  HXMineLoginHeadView.m
//  HXBudsProject
//
//  Created by n on 2017/3/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMineLoginHeadView.h"

@implementation HXMineLoginHeadView

+ (instancetype)initMineLoginHeadViewWithXib{


 return [[[NSBundle mainBundle]loadNibNamed:@"HXMineLoginHeadView" owner:nil options:nil] lastObject];

}
- (void)awakeFromNib {

    [super awakeFromNib];
    [self.iconImagV setRoundImageViewWithBorderWidth:0];

}

@end
