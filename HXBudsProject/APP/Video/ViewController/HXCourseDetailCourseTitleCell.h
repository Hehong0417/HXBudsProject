//
//  HXCourseDetailCourseTitleCell.h
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXCurrilumDetailModel.h"

@interface HXCourseDetailCourseTitleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *starView;
@property(nonatomic,strong) UINavigationController *nav;
@property(nonatomic,strong) HXCurrilumPdModel *pdModel;
@property(nonatomic,strong) NSString *count;

@property (weak, nonatomic) IBOutlet UILabel *curr_title;
@property (weak, nonatomic) IBOutlet UILabel *when_long;
@property (weak, nonatomic) IBOutlet UILabel *read;
@property (weak, nonatomic) IBOutlet UILabel *curriculum_price;


+ (instancetype)initCourseDetailCourseTitleCellWithXib;

@end
