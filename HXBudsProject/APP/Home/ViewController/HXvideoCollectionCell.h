//
//  HXvideoCollectionCell.h
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXSubjectVideoListModel.h"

@interface HXvideoCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoImagV;
@property(nonatomic,strong) UINavigationController *nav;
@property (weak, nonatomic) IBOutlet UIImageView *videoIconImgV;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLab;
@property (weak, nonatomic) IBOutlet UILabel *videoTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *viewsLab;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property(nonatomic,strong) HXSubjectVideoModel *model;


@end
