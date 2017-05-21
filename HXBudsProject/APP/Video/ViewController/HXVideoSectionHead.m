//
//  HXVideoSectionHead.m
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXVideoSectionHead.h"
#import "HXSubjectVideoVC.h"


@implementation HXVideoSectionHead

- (instancetype)initWithFrame:(CGRect)frame {

    if (self =[super initWithFrame:frame]) {
        //分类图片
        self.categoryImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 10, 35)];
        self.categoryImageV.contentMode = UIViewContentModeLeft;
        //categoryImageV.backgroundColor = kOrangeColor;
        [self addSubview:self.categoryImageV];
        //标题
        self.headTitleLab = [[UILabel alloc]init];
        self.headTitleLab.textColor = kBlackColor;
        self.headTitleLab.textAlignment = NSTextAlignmentLeft;
        self.headTitleLab.font = FONT(14);

        [self addSubview:self.headTitleLab];
        //描述
        self.discribLab = [[UILabel alloc]init];
        self.discribLab.textColor = RGB(186, 186, 186);
        self.discribLab.font = FONT(12);
        self.discribLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.discribLab];

    }

    return self;
}
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.categoryImageV.image = [UIImage imageNamed:_imageName];
}
- (void)setHeadtitle:(NSString *)headtitle {
    _headtitle = headtitle;
    CGSize nameSize = [self.headtitle lh_sizeWithFont:[UIFont systemFontOfSize:self.labFont] constrainedToSize:CGSizeMake(SCREEN_WIDTH, 25)];
    self.headTitleLab.frame = CGRectMake(25, 0, nameSize.width+5, 35);
    self.headTitleLab.text = _headtitle;
}
- (void)setDiscribText:(NSString *)discribText {

    _discribText = discribText;
   
}
- (void)layoutSubviews {

    XYQButton *changeBtn = [XYQButton ButtonWithFrame:CGRectMake(SCREEN_WIDTH - 60, 2, 60, self.frame.size.height-2) imgaeName:@"more" titleName:self.rightBtnTitle contentType:self.contentType buttonFontAttributes:self.btnFontAttributes tapAction:^(XYQButton *button) {
        
//        [self.nav pushVC:[HXSubjectVideoVC new]];
        
    }];
    changeBtn.enabled = NO;
    [self addSubview:changeBtn];
    
}


@end
