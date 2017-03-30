//
//  HXFraiendDynamicStateCell.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXFraiendDynamicStateCell.h"

@implementation HXFraiendDynamicStateCell



+ (instancetype)initFraiendDynamicStateCellWithXib{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"HXFraiendDynamicStateCell" owner:nil options:nil]lastObject];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
