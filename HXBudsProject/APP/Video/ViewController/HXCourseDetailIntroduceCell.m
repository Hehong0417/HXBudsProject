
//
//  HXCourseDetailIntroduceCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseDetailIntroduceCell.h"

@implementation HXCourseDetailIntroduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

+ (instancetype)initCourseDetailIntroduceCellWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXCourseDetailIntroduceCell" owner:nil options:nil]lastObject];

}
- (void)setPdModel:(HXCurrilumPdModel *)pdModel {
    _pdModel = pdModel;
    self.introduction.text = pdModel.introduction;

}
@end
