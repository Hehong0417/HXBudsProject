//
//  HXInstrumentCell.m
//  HXBudsProject
//
//  Created by n on 2017/5/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXInstrumentCell.h"

@implementation HXInstrumentCell

+ (instancetype)initInstrumentCellWithXib{

  return [[[NSBundle mainBundle]loadNibNamed:@"HXInstrumentCell" owner:nil options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}
- (void)setModel:(HXSubjectVideoModel *)model {
    _model = model;
    
    self.curr_title.text = model.curr_title;
    [self.curr_picture sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.curr_picture)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
    self.read.text = [NSString stringWithFormat:@"%@人看过",model.read?model.read:@"0"];
    self.when_long.text = [NSString stringWithFormat:@"时长:%@分钟",model.when_long?model.when_long:@"0"];
    self.curriculum_price.text = [NSString stringWithFormat:@"￥%@",model.curriculum_price?model.curriculum_price:@"0.00"];
}

@end
