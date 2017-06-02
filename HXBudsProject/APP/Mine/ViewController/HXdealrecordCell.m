
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
    if ([model.con_type_text isEqualToString:@"充值"]) {
        self.tran_money.text = [NSString stringWithFormat:@"+%@",model.con_money];
    }else if([model.con_type_text isEqualToString:@"支出"]){
        self.tran_money.text = [NSString stringWithFormat:@"-%@",model.con_money];
    }
    
}
- (void)setWithDrawmodel:(HXConsumptionVarListModel *)withDrawmodel {

    _withDrawmodel = withDrawmodel;
    self.titleLab.text = [NSString stringWithFormat:@"提现到%@",withDrawmodel.with_acc];
    self.ctimeLab.text = withDrawmodel.ctime;
    self.tran_money.text = [NSString stringWithFormat:@"-%@",withDrawmodel.with_money];

}


@end
