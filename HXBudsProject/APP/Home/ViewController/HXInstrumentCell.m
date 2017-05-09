//
//  HXInstrumentCell.m
//  HXBudsProject
//
//  Created by n on 2017/5/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXInstrumentCell.h"

@implementation HXInstrumentCell

+ (instancetype)initInstrumentCellWithXib{

  return [[[NSBundle mainBundle]loadNibNamed:@"HXInstrumentCell" owner:nil options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
