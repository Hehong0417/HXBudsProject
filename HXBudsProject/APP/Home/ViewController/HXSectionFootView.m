//
//  HXSectionFootView.m
//  HXBudsProject
//
//  Created by n on 2017/5/11.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSectionFootView.h"

@implementation HXSectionFootView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        UIView *view = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10) backColor:KVCBackGroundColor];
        [self addSubview:view];

    }
    return self;
}
@end
