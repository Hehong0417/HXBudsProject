//
//  HXCourseDetailCommentCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseDetailCommentCell.h"

@implementation HXCourseDetailCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.commentIco_ImagV lh_setCornerRadius:25 borderWidth:0 borderColor:nil];
    
}

+ (instancetype)initCourseDetailCommentCellWithXib{

    return [[[NSBundle mainBundle] loadNibNamed:@"HXCourseDetailCommentCell" owner:nil options:nil] lastObject];

}

@end
