//
//  HXMessageCell.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMessageCell.h"

@implementation HXMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.ico lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    
}
+ (instancetype)initMessageCellWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXMessageCell" owner:self options:nil]lastObject];

}

@end
