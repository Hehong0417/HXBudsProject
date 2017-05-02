//
//  HXInformationCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSujectVideoListCell.h"

@implementation HXSujectVideoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)initSubjectVideoListCellWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXSujectVideoListCell" owner:nil options:nil]lastObject];

}
- (void)setModel:(HXSubjectVideoModel *)model {

    _model = model;
    [self.curr_picture sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.curr_picture)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
    self.curr_title.text = model.curr_title;
    self.when_long.text = [NSString stringWithFormat:@"时长：%@分钟",model.when_long];
    self.read.text = [NSString stringWithFormat:@"%@人看过",model.read];
}
@end
