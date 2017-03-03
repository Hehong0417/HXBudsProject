//
//  HXInformationCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXInformationCell.h"

@implementation HXInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)initInformationCellWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXInformationCell" owner:nil options:nil]lastObject];

}

@end
