//
//  HXInformationCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSujectVideoListCell.h"

@implementation HXSujectVideoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)initSubjectVideoListCellWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXSujectVideoListCell" owner:nil options:nil]lastObject];

}

@end
