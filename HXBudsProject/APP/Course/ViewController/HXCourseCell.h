//
//  HXCourseCell.h
//  HXBudsProject
//
//  Created by n on 2017/2/20.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXCourseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *playBgImageV;
@property (weak, nonatomic) IBOutlet UIImageView *playImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UIView *starView;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *viewsLab;


+ (instancetype)initCourseCellWithXib;

@end
