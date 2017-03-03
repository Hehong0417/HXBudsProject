//
//  HXPianoDetailCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXPianoDetailCell.h"

@implementation HXPianoDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)initPianoDetailCellWithXib{

    return [[[NSBundle mainBundle] loadNibNamed:@"HXPianoDetailCell" owner:nil options:nil] lastObject];

}


@end
