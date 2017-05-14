//
//  HXInstrumentCell.h
//  HXBudsProject
//
//  Created by n on 2017/5/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXSubjectVideoListModel.h"
@interface HXInstrumentCell : UITableViewCell

+ (instancetype)initInstrumentCellWithXib;
@property(nonatomic,strong)HXSubjectVideoModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *curr_picture;

@property (weak, nonatomic) IBOutlet UILabel *curr_title;
@property (weak, nonatomic) IBOutlet UILabel *read;
@property (weak, nonatomic) IBOutlet UILabel *when_long;
@property (weak, nonatomic) IBOutlet UILabel *curriculum_price;

@end
