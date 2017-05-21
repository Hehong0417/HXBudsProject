//
//  HXInstrumentSectionHead.h
//  HXBudsProject
//
//  Created by n on 2017/5/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXInstrumentSectionHead : UIView

+ (instancetype)initInstrumentSectionHeadWithXib;
@property (weak, nonatomic) IBOutlet UILabel *courseCount;

@end
