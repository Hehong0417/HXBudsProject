//
//  HXMyHomeHeadView.m
//  HXBudsProject
//
//  Created by n on 2017/3/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyHomeHeadView.h"
#import "HXPersonInfoVC.h"
#import "HXMessageVC.h"


@implementation HXMyHomeHeadView

-(void)awakeFromNib {
    [super awakeFromNib];

    [self.editBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    [self.messageBtn lh_setCornerRadius:3 borderWidth:1 borderColor:APP_COMMON_COLOR];
    
}
+ (instancetype)initMyHomeHeadViewWithXib{

  return [[[NSBundle mainBundle]loadNibNamed:@"HXMyHomeHeadView" owner:self options:nil] lastObject];


}
- (IBAction)editAction:(UIButton *)sender {

    HXPersonInfoVC *vc2 = [HXPersonInfoVC new];
    [self.nav pushVC:vc2];


}

- (IBAction)messageAction:(UIButton *)sender {
    
    
    HXMessageVC *vc1 = [HXMessageVC new];
    [self.nav pushVC:vc1];
  
    
}



@end
