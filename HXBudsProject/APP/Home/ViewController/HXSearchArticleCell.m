//
//  HXSearchArticleCell.m
//  HXBudsProject
//
//  Created by n on 2017/3/27.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSearchArticleCell.h"

@implementation HXSearchArticleCell


+(instancetype)initSearchArticleCellWithXib{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"HXSearchArticleCell" owner:nil options:nil] lastObject];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
