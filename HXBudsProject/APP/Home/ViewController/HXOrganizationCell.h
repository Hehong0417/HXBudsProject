//
//  HXOrganizationCell.h
//  HXBudsProject
//
//  Created by n on 2017/2/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTeacherListModel.h"

@interface HXOrganizationCell : UITableViewCell

+ (instancetype)initOrganizationCellWithXib;

@property (weak, nonatomic) IBOutlet UIImageView *iconImagV;

@property (strong, nonatomic)  HXteacherVarListModel *teacherModel;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLab;
@property (weak, nonatomic) IBOutlet UILabel *introduceLab;

@end
