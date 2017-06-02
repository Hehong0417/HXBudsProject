//
//  HXGradeCommentCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXGradeCommentCell.h"

@implementation HXGradeCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *titleLab = [UILabel lh_labelWithFrame:CGRectMake(0, 20, 150, 30) text:@"打个分，评论一下吧！" textColor:[UIColor colorWithHexString:@"#71C696"] font:FONT(14) textAlignment:NSTextAlignmentCenter backgroundColor:kWhiteColor];
        titleLab.centerX = SCREEN_WIDTH/2;
        [self.contentView addSubview:titleLab];
        
        UIView *bgView = [UIView lh_viewWithFrame:CGRectMake(0, CGRectGetMaxY(titleLab.frame)+10, 100, 40) backColor:kWhiteColor];
        
        for (NSInteger i = 0; i < 5; i++) {
            
            CGFloat btn_w =  bgView.mj_w/5;
            
            UIButton *btn = [UIButton lh_buttonWithFrame:CGRectMake(i*btn_w, 0, btn_w, 40) target:self action:@selector(btnAction:) image:[UIImage imageNamed:@"Star_comment"]];
            
            [bgView addSubview:btn];
        }
        
        bgView.centerX = titleLab.centerX;
        [self.contentView addSubview:bgView];
    }
  
    return self;

}
- (void)btnAction:(UIButton *)btn{
    
    [self.delegate gradeCommentStarAction:btn];
    
}

@end
