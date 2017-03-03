//
//  HXPayInformationCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXPayInformationCell.h"

@implementation HXPayInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
+ (instancetype)initPayInformationCellWithXib{


    return [[[NSBundle mainBundle]loadNibNamed:@"HXPayInformationCell" owner:nil options:nil] lastObject];

}

@end
