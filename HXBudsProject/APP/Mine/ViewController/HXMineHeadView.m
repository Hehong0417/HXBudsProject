//
//  HXMineHeadView.m
//  HXBudsProject
//
//  Created by n on 2017/3/2.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMineHeadView.h"
#import "HXPersonInfoVC.h"
#import "HXPayDetailTVC.h"

@implementation HXMineHeadView


+ (instancetype)initmineHeadViewWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXMineHeadView" owner:nil options:nil] lastObject];


}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.icon_imgV lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = @[(__bridge id)RGB(118, 198, 170).CGColor,(__bridge id)RGB(107, 199, 225).CGColor];
    layer.locations = @[@0.2,@0.9];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(0, 1.0);
    layer.frame = CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(257));

    [self.bgView.layer addSublayer:layer];
     

}


- (IBAction)backAction:(UIButton *)sender {
    
    [self.nav pushVC:[HXPersonInfoVC new]];
    
    
}



@end
