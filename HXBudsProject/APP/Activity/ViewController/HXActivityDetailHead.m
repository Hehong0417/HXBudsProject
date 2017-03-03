
//
//  HXActivityDetailHead.m
//  HXBudsProject
//
//  Created by n on 2017/2/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXActivityDetailHead.h"

@implementation HXActivityDetailHead

+ (instancetype)initActivityDetailHeadWithXib{

    return [[[NSBundle mainBundle] loadNibNamed:@"HXActivityDetailHead" owner:nil options:nil] lastObject];

}
- (void)awakeFromNib {

    [super awakeFromNib];
    
    
    [self.stateBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];

}


@end
