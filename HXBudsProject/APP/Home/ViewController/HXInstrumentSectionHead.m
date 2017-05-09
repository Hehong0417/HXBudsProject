//
//  HXInstrumentSectionHead.m
//  HXBudsProject
//
//  Created by n on 2017/5/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXInstrumentSectionHead.h"

@implementation HXInstrumentSectionHead

+ (instancetype)initInstrumentSectionHeadWithXib{

    return [[[NSBundle mainBundle] loadNibNamed:@"HXInstrumentSectionHead" owner:nil options:nil] lastObject];
}


@end
