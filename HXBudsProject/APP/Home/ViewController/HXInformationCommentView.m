//
//  HXInformationCommentView.m
//  HXBudsProject
//
//  Created by n on 2017/3/7.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXInformationCommentView.h"

@implementation HXInformationCommentView

+ (instancetype)initInformationCommentViewWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXInformationCommentView" owner:nil options:nil] firstObject];
    
}

@end
