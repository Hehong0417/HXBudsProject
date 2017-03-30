//
//  HXMyAttentionCell.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyAttentionCell.h"

@implementation HXMyAttentionCell

+ (instancetype)initMyAttentionCellWithXib{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"HXMyAttentionCell" owner:nil options:nil]lastObject];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.iconImagV lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    
    
    
}


@end
