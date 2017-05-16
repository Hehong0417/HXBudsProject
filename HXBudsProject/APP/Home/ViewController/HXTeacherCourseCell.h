//
//  HXTeacherCourseCell.h
//  HXBudsProject
//
//  Created by n on 2017/5/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXSubjectVideoListModel.h"

@interface HXTeacherCourseCell : UICollectionViewCell

@property (strong, nonatomic)  HXSubjectVideoModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *curr_Picture;
@property (weak, nonatomic) IBOutlet UILabel *read;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *currimTitle;

@end
