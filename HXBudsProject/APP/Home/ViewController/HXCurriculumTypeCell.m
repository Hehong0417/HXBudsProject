//
//  HXCurriculumTypeCell.m
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCurriculumTypeCell.h"
#import "HXInstrumentVC.h"


@implementation HXCurriculumTypeCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        //列数
        NSInteger lineCount = 4;
        NSArray *titleArr = @[@"西洋乐器",@"民族乐器",@"舞蹈",@"书法",@"绘画",@"声乐",@"武术",@"语言艺术"];
        for (NSInteger i = 0; i< 8; i++) {
            NSInteger line = i % lineCount;
            NSInteger row = i / lineCount;
            CGFloat btn_W = WidthScaleSize_H(70);
            CGFloat btn_H = WidthScaleSize_H(80);
            //列间距
            CGFloat lineMargin = (SCREEN_WIDTH - 20 - lineCount *btn_W) / 8;
            //行间距
            CGFloat rowMargin = lineMargin;
            
            CGFloat btn_x = lineMargin + (lineMargin*2 + btn_W)*line;
            
            CGFloat btn_y = rowMargin + (rowMargin + btn_H)*row;

            XYQButton *curriTypeBtn = [XYQButton ButtonWithFrame:CGRectMake(btn_x, btn_y, btn_W, btn_H)  imgaeName:@"" titleName:titleArr[i] contentType:TopImageBottomTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kBlackColor fontsize:14] tapAction:^(XYQButton *button) {
                
                HXInstrumentVC *vc = [HXInstrumentVC new];
                [self.nav pushVC:vc];
                
            }];
            curriTypeBtn.backgroundColor = APP_COMMON_COLOR;
            [self addSubview:curriTypeBtn];
        }

    }
    
    return self;
}


@end
