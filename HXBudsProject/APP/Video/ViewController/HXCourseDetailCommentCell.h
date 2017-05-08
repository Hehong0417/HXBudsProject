//
//  HXCourseDetailCommentCell.h
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXcurriculumreviewModel.h"


@interface HXCourseDetailCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *tip;

@property (weak, nonatomic) IBOutlet UIImageView *commentIco_ImagV;
@property (weak, nonatomic) IBOutlet UILabel *curriReView_Title;
@property (weak, nonatomic) IBOutlet UILabel *ctime;
@property (weak, nonatomic) IBOutlet UILabel *reViewContent;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (strong, nonatomic) HXcurriculumreviewVarListModel *model;


+ (instancetype)initCourseDetailCommentCellWithXib;

@end
