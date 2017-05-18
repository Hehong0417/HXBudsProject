//
//  HXSearchVideoCell.h
//  HXBudsProject
//
//  Created by n on 2017/3/27.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXSubjectVideoListModel.h"

@interface HXSearchVideoCell : UITableViewCell

+ (instancetype)initSearchVideoCellWithXib;
@property(nonatomic,strong)HXSubjectVideoModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *curri_picture;
@property (weak, nonatomic) IBOutlet UILabel *curri_title;
@property (weak, nonatomic) IBOutlet UILabel *the_name;
@property (weak, nonatomic) IBOutlet UIImageView *the_head;

@end
