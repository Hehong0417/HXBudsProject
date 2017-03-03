//
//  HXArtTestInformationCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXArtTestInformationCell.h"

@implementation HXArtTestInformationCell


+(instancetype)initWithArtTestInformationXib{

    return [[[NSBundle mainBundle] loadNibNamed:@"HXArtTestInformationCell" owner:nil options:nil] lastObject];


}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
