//
//  HXTeacherCollectionCell.h
//  HXBudsProject
//
//  Created by n on 2017/4/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTeacherListModel.h"

typedef void(^followSelectedBlock)(BOOL followed);

@interface HXTeacherCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImagV;

@property (weak, nonatomic) IBOutlet UILabel *teacherNameLab;

@property (weak, nonatomic) IBOutlet UILabel *introduceLab;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;

@property (strong, nonatomic)  HXteacherVarListModel *teacherModel;

@property (copy, nonatomic)  followSelectedBlock followSelectedBlock;



@end
