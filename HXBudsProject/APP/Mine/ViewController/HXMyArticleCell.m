//
//  HXMyArticleCell.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyArticleCell.h"

@implementation HXMyArticleCell

+ (instancetype)initMyArticleCellWithXib{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"HXMyArticleCell" owner:nil options:nil]lastObject];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
