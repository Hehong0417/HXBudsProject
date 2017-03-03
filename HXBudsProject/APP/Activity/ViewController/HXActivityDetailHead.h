//
//  HXActivityDetailHead.h
//  HXBudsProject
//
//  Created by n on 2017/2/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXActivityDetailHead : UIView

+ (instancetype)initActivityDetailHeadWithXib;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageV;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (weak, nonatomic) IBOutlet UIButton *stateBtn;

@end
