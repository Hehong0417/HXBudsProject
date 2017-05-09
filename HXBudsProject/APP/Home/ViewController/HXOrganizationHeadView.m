//
//  HXOrganizationHeadView.m
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationHeadView.h"

@implementation HXOrganizationHeadView

+ (instancetype)initOrganizationHeadViewWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXOrganizationHeadView" owner:nil options:nil] lastObject];
}
@end
