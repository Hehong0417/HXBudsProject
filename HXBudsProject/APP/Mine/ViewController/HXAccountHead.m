//
//  HXAccountHead.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXAccountHead.h"
#import "HXBalanceRechargeVC.h"

@implementation HXAccountHead

- (void)awakeFromNib {
    [super awakeFromNib];

}
+ (instancetype)initWithAccountHeadWithXib{

    return [[[NSBundle mainBundle] loadNibNamed:@"HXAccountHead" owner:nil options:nil] lastObject];
}
@end
