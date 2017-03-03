//
//  HXOrganizationCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationCell.h"

@implementation HXOrganizationCell

+ (instancetype)initOrganizationCellWithXib{

    return [[[NSBundle mainBundle] loadNibNamed:@"HXOrganizationCell" owner:nil options:nil] lastObject];

}

- (void)awakeFromNib {

    [super awakeFromNib];
    [self.evulateLab lh_setCornerRadius:3 borderWidth:1 borderColor:[UIColor colorWithHexString:@"#F6A623"]];
    
    
    
}
@end
