//
//  HXModuleListCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXModuleListCell.h"

@interface HXModuleListCell ()


@end

@implementation HXModuleListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubViews];
    }
    
    return self;
}
- (void)addSubViews{
  
    NSArray *titleArr = @[@"精品课程",@"名师机构",@"演出活动",@"艺术考试"];
    
    CGFloat rowMargin = WidthScaleSize_H(8);
    CGFloat lineMargin = WidthScaleSize_H(20);

    
    NSInteger num = 4;
    NSInteger LineNum = 4;
    for (NSInteger i = 0; i<num; i++) {
        
        NSInteger row = i / LineNum;
        NSInteger line = i % LineNum;
        CGFloat btnW = (SCREEN_WIDTH - 5*rowMargin)/4;
        CGFloat btnH = WidthScaleSize_H(60) - 2*lineMargin ;
        UIButton *btn = [UIButton lh_buttonWithFrame:CGRectMake(rowMargin+line*(btnW+5),lineMargin,btnW, btnH) target:self action:@selector(btnAction:) title:titleArr[i] titleColor:FontGrayColor font:FONT(16) backgroundColor:kWhiteColor];
        btn.tag = i+1;
        if (i < num-1) {
            
            UIView *verticalLine = [UIView lh_viewWithFrame:CGRectMake(CGRectGetMaxX(btn.frame),lineMargin,1, btnH)  backColor:LineDeepColor];
            
            [self.contentView addSubview:verticalLine];
        }
       
        [self.contentView addSubview:btn];
    }
    

}
- (void)btnAction:(UIButton *)btn {
 
    if ([self.delegate respondsToSelector:@selector(btnClickWithIndex:)]) {
        
        [self.delegate btnClickWithIndex:btn.tag];
    }

}
@end
