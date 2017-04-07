//
//  HXSearchVideoCell.m
//  HXBudsProject
//
//  Created by n on 2017/3/27.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSearchVideoCell.h"

@implementation HXSearchVideoCell

+(instancetype)initSearchVideoCellWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXSearchVideoCell" owner:nil options:nil] lastObject];

}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
