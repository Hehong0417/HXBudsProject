
//
//  HXdealrecordCell.m
//  HXBudsProject
//
//  Created by n on 2017/5/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXdealrecordCell.h"

@implementation HXdealrecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HXConsumptionVarListModel *)model {

    _model = model;
    self.titleLab.text = model.descs;
    self.ctimeLab.text = model.ctime;
    self.tran_money.text = model.con_money;
}

@end
