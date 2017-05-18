//
//  HXMessageCell.h
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXMyMessageModel.h"

@interface HXMessageCell : UITableViewCell

+ (instancetype)initMessageCellWithXib;

@property (strong, nonatomic)  HXMyMessageVarlistModel *model;

@property (weak, nonatomic) IBOutlet UILabel *meassge_title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *ctime;

@end
