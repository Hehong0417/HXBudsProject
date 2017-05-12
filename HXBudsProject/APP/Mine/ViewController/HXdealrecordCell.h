//
//  HXdealrecordCell.h
//  HXBudsProject
//
//  Created by n on 2017/5/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXConsumptionModel.h"

@interface HXdealrecordCell : UITableViewCell
@property(nonatomic,strong) HXConsumptionVarListModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *ctimeLab;
@property (weak, nonatomic) IBOutlet UILabel *tran_money;

@end
