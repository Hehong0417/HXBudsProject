//
//  HXPayWaysCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXPayWaysCell.h"

@implementation HXPayWaysCell


+ (instancetype)initPayWaysCellWithXib{
 
    return [[[NSBundle mainBundle]loadNibNamed:@"HXPayWaysCell" owner:nil options:nil] lastObject];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (IBAction)cancelPayAtion:(UIButton *)sender {
    
    
    
}
- (IBAction)commitPayAction:(UIButton *)sender {
    
    
    
    
}


@end
