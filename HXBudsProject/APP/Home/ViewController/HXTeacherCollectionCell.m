//
//  HXTeacherCollectionCell.m
//  HXBudsProject
//
//  Created by n on 2017/4/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXTeacherCollectionCell.h"

@implementation HXTeacherCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    [self.iconImagV lh_setCornerRadius:37 borderWidth:0 borderColor:nil];

}
- (void)setTeacherModel:(HXteacherVarListModel *)teacherModel {

    _teacherModel = teacherModel;
    
    [self.iconImagV sd_setImageWithURL:[NSURL URLWithString:kAPITeacherImageFromUrl(teacherModel.headportrait)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
   
    self.teacherNameLab.text = teacherModel.teacherteam_name;
    self.introduceLab.text = teacherModel.teacherteam_desc;
    
    if (!teacherModel.the_name) {
        self.introduceLab.height = 21;
    }
    
    
}

@end
