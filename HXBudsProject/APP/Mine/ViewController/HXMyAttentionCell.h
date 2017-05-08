//
//  HXMyAttentionCell.h
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTeacherListModel.h"
#import "HXAttentionFriendModel.h"

@interface HXMyAttentionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImagV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *hobbyLab;

@property (nonatomic, strong) HXteacherVarListModel *model;
@property (nonatomic, strong) HXAttentionFriendVarlistModel *friendsModel;


+ (instancetype)initMyAttentionCellWithXib;
@end
