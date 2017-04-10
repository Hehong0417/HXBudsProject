//
//  HXArticleCellTwo.h
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXArticleCellTwo : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *subjectLab;
@property (weak, nonatomic) IBOutlet UIImageView *rightIconImgV;
@property (weak, nonatomic) IBOutlet UIImageView *teacherIconImagV;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLab;



@property(nonatomic,strong) UINavigationController *nav;
+ (instancetype)initArticleCellTwoWithXib;

@end
