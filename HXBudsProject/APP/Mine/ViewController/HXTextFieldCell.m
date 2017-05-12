//
//  HXTextFieldCell.m
//  HXBudsProject
//
//  Created by n on 2017/5/11.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXTextFieldCell.h"

@implementation HXTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.leftTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 44)];
        self.leftTextLabel.font = FONT(14);
        self.leftTextLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.leftTextLabel];
        
        //
        self.textFiled = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTextLabel.frame)+10, 0, SCREEN_WIDTH -CGRectGetMaxX(self.leftTextLabel.frame) - 10 -10, 44)];
        self.textFiled.font = FONT(14);
        self.textFiled.secureTextEntry = YES;
        [self.contentView addSubview:self.textFiled];
        //
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

}
@end
