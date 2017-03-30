//
//  HXVideoSectionHead.m
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXVideoSectionHead.h"

@implementation HXVideoSectionHead

- (instancetype)initWithFrame:(CGRect)frame {

    if (self =[super initWithFrame:frame]) {
        
        
    }

    return self;
}
- (void)layoutSubviews {

    //分类图片
    UIImageView *categoryImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 35)];
    categoryImageV.image = [UIImage imageNamed:@"category"];
    categoryImageV.contentMode = UIViewContentModeLeft;
    //    categoryImageV.backgroundColor = kOrangeColor;
    [self addSubview:categoryImageV];
    
    
    CGSize nameSize = [self.headtitle lh_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH, 30)];
    //标题
    UILabel *headTitleLab = [UILabel lh_labelWithFrame:CGRectMake(10, 4, nameSize.width, self.frame.size.height-4) text:self.headtitle textColor:kBlackColor font:FONT(self.labFont) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    [self addSubview:headTitleLab];
    
    //描述
    UILabel *discribLab = [UILabel lh_labelWithFrame:CGRectMake(CGRectGetMaxX(headTitleLab.frame)+10, 4, 200, self.frame.size.height-4) text:self.discribText textColor:[UIColor colorWithHexString:@"#BABABA"] font:FONT(12) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    [self addSubview:discribLab];
    
    XYQButton *changeBtn = [XYQButton ButtonWithFrame:CGRectMake(SCREEN_WIDTH - WidthScaleSize_W(80), 2, WidthScaleSize_W(80), self.frame.size.height-2) imgaeName:self.imageName titleName:self.rightBtnTitle contentType:self.contentType buttonFontAttributes:self.btnFontAttributes tapAction:^(XYQButton *button) {
        
      
    }];
    changeBtn.enabled = NO;
    [self addSubview:changeBtn];
    
}


@end
