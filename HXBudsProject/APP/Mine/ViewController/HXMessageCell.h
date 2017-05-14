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
@property (weak, nonatomic) IBOutlet UIImageView *ico;
@property (strong, nonatomic)  HXMyMessageVarlistModel *model;


@end
