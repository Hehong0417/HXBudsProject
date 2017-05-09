//
//  HXChoicenessCell.h
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXSubjectVideoListModel.h"

@interface HXChoicenessCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *curr_picture;
@property (weak, nonatomic) IBOutlet UILabel *curr_title;
@property (weak, nonatomic) IBOutlet UILabel *read;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *the_name;
@property (weak, nonatomic) IBOutlet UIImageView *The_headportrait;
@property(nonatomic,strong) HXSubjectVideoModel *model;
@property(nonatomic,strong) UINavigationController *nav;

@end
