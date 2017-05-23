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
    [self.iconImagV sd_setImageWithURL:[NSURL URLWithString:kAPITeacherImageFromUrl(teacherModel.the_headportrait)] placeholderImage:[UIImage imageNamed:@"person_ico"]];
    
    self.teacherNameLab.text = teacherModel.the_name;
    self.introduceLab.text = teacherModel.hobby;
    UIColor *backgroud = teacherModel.the_name ?kWhiteColor:KPlaceHoldColor;
    if (!teacherModel.the_name) {
        self.introduceLab.height = 21;
    }
        UIColor *introBackgroud = teacherModel.hobby ?kWhiteColor:KPlaceHoldColor;
    self.introduceLab.backgroundColor = introBackgroud;
    self.teacherNameLab.backgroundColor = backgroud;
    if (teacherModel.distance.floatValue >1000) {
        
        self.distanceLab.text = [NSString stringWithFormat:@"%.2fkm",teacherModel.distance.floatValue/1000];
        
    }else{
        
        self.distanceLab.text = [NSString stringWithFormat:@"%@m",teacherModel.distance];  ;
        
    }

}

- (void)setOrganizationModel:(HXOrganizationVarListModel *)organizationModel {
    _organizationModel = organizationModel;
    [self.iconImagV sd_setImageWithURL:[NSURL URLWithString:kAPImechanismFromUrl(organizationModel.mechanism_logo)] placeholderImage:[UIImage imageNamed:@"person_ico"]];
    
    self.teacherNameLab.text = organizationModel.mechanism_name;
    self.introduceLab.text = [NSString stringWithFormat:@"%@",organizationModel.mechanism_address];
    
    UIColor *backgroud = organizationModel.mechanism_name ?kWhiteColor:KPlaceHoldColor;
    if (!organizationModel.mechanism_name) {
        self.introduceLab.height = 21;
    }
    UIColor *introBackgroud = organizationModel.mechanism_desc ?kWhiteColor:KPlaceHoldColor;
    self.introduceLab.backgroundColor = introBackgroud;
    self.teacherNameLab.backgroundColor = backgroud;

    if (organizationModel.distance.floatValue >1000) {
        
        self.distanceLab.text = [NSString stringWithFormat:@"%.2fkm",organizationModel.distance.floatValue/1000];

    }else{
    
        self.distanceLab.text = [NSString stringWithFormat:@"%@m",organizationModel.distance];  ;
        
    }

}

@end
