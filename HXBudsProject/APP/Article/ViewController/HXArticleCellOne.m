//
//  HXArticleCellOne.m
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXArticleCellOne.h"
#import "HXSubjectListTVC.h"


@implementation HXArticleCellOne

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
    }
    return self;
}

- (void)setSubjectArr:(NSArray *)subjectArr isViewMore:(BOOL) isViewMore cellHeight:(float) cellHeight{

    float butX = 15;
    float butY = 10;
    for(int i = 0; i < subjectArr.count; i++){
        
        //宽度自适应
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        CGRect frame_W = [subjectArr[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        
        if (butX+frame_W.size.width+20 > SCREEN_WIDTH-15) {
            
            butX = 15;
            
            butY += 45;
        }
        
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+20, 30)];
        [but setTitle:subjectArr[i] forState:UIControlStateNormal];
        [but setTitleColor:APP_COMMON_COLOR forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13];
        but.layer.cornerRadius = 8;
        but.layer.borderColor = APP_COMMON_COLOR.CGColor;
        but.layer.borderWidth = 1;
        but.tag = i+1;
        //10 + 30 + 15 = 55;
        if (!isViewMore &&(butY>55)) {
            
            but.hidden = YES;
        
        }else{
            
            but.hidden = NO;
        }
        [but addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:but];
        
        butX = CGRectGetMaxX(but.frame)+10;
        
    }

}
- (void)btnClick:(UIButton *)btn{

    HXSubjectListTVC *vc = [HXSubjectListTVC new];
//    vc.titleStr = self.subjectArr[btn.tag - 1];
    [self.vc pushVC:vc];

}
@end
