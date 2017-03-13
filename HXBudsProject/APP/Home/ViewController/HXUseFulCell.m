//
//  HXUseFulCell.m
//  HXBudsProject
//
//  Created by n on 2017/3/7.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXUseFulCell.h"

@implementation HXUseFulCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)initUseFulCellWithXib{


    return [[[NSBundle mainBundle]loadNibNamed:@"HXUseFulCell" owner:nil options:nil]lastObject];

}
@end
