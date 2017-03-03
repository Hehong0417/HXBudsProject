//
//  HXActivityDetailCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXActivityDetailCell.h"

@implementation HXActivityDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+ (instancetype)initActivityDetailCellWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXActivityDetailCell" owner:nil options:nil]lastObject ];

}

@end
