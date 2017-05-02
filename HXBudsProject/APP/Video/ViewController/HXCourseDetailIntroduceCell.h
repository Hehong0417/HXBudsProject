//
//  HXCourseDetailIntroduceCell.h
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXCurrilumDetailModel.h"

@interface HXCourseDetailIntroduceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *showAllBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *introduction;

@property(nonatomic,strong) HXCurrilumPdModel *pdModel;


+ (instancetype)initCourseDetailIntroduceCellWithXib;
@end
