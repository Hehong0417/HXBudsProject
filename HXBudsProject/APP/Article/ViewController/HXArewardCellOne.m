//
//  HXArewardCellOne.m
//  HXBudsProject
//
//  Created by n on 2017/5/12.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXArewardCellOne.h"

@implementation HXArewardCellOne

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        self.arewardImagV = [UIImageView lh_imageViewWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 115) image:[UIImage imageNamed:@"dashang"]];
        self.arewardImagV.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:self.arewardImagV];
        //
        self.arewardLab = [UILabel lh_labelWithFrame:CGRectMake(0, CGRectGetMaxY(self.arewardImagV.frame), SCREEN_WIDTH, 40) text:@"您的赞赏，是我动力的源泉" textColor:kGrayColor font:FONT(15) textAlignment:NSTextAlignmentCenter backgroundColor:kWhiteColor];
        [self.contentView addSubview:self.arewardLab];
        
    }
    return self;

}
@end
