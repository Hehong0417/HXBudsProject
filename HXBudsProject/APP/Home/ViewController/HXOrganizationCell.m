//
//  HXOrganizationCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationCell.h"

@implementation HXOrganizationCell

+ (instancetype)initOrganizationCellWithXib{

    return [[[NSBundle mainBundle] loadNibNamed:@"HXOrganizationCell" owner:nil options:nil] lastObject];

}

- (void)awakeFromNib {

    [super awakeFromNib];
    [self.iconImagV lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    
}
- (void)setTeacherModel:(HXteacherVarListModel *)teacherModel {

    _teacherModel = teacherModel;
    [self.iconImagV sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(teacherModel.the_headportrait)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
    
    self.teacherNameLab.text = teacherModel.the_name;
    self.introduceLab.text = teacherModel.hobby;
    UIColor *backgroud = teacherModel.the_name ?kWhiteColor:KPlaceHoldColor;
    if (!teacherModel.the_name) {
        self.introduceLab.height = 21;
    }
        UIColor *introBackgroud = teacherModel.hobby ?kWhiteColor:KPlaceHoldColor;
    self.introduceLab.backgroundColor = introBackgroud;
    self.teacherNameLab.backgroundColor = backgroud;
}
@end
