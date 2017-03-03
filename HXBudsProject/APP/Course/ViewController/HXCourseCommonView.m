//
//  HXCourseCommonView.m
//  HXBudsProject
//
//  Created by n on 2017/2/20.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseCommonView.h"
#import "HXPianoDetailVC.h"


@implementation HXCourseCommonView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self == [super initWithFrame:frame]) {
        
        
//        [self addBttonInView];
        
    }

    return self;
}
- (void)setDataArr:(NSArray *)dataArr {

    _dataArr = dataArr;
    
    //列数
    NSInteger lineCount = 4;
    
    for (NSInteger i = 0; i< self.dataArr.count; i++) {
        
        NSInteger line = i % lineCount;
        NSInteger row = i / lineCount;
        CGFloat btn_W = WidthScaleSize_H(60);
        CGFloat btn_H = WidthScaleSize_H(60);
        //列间距
        CGFloat lineMargin = (SCREEN_WIDTH - lineCount *btn_W) / 8;
        //行间距
        CGFloat rowMargin = lineMargin;
        
        CGFloat btn_x = lineMargin + (lineMargin*2 + btn_W)*line;
        
        CGFloat btn_y = rowMargin + (rowMargin + btn_H)*row;
        
        UIButton *btn = [UIButton lh_buttonWithFrame:CGRectMake(btn_x, btn_y, btn_W, btn_H) target:self action:@selector(btnAction:) title:self.dataArr[i] titleColor:kWhiteColor font:FONT(14) backgroundColor:[UIColor colorWithHexString:self.colorArr[i]]];
        [btn lh_setCornerRadius:btn_W/2 borderWidth:0 borderColor:nil];
        
        
        [self addSubview:btn];
    }


}
- (void)btnAction:(UIButton *)btn{

    [self.nav pushVC:[HXPianoDetailVC new]];


}

- (NSArray *)colorArr {

    if (!_colorArr) {
        _colorArr = @[@"#7FE1E4",@"#A4E55C",@"#ECCA81",@"#EA87C6",@"#9899B3",@"#A99182",@"#71D6B4",@"#FFB39B",@"#AAACED",@"#E9B06E",@"#CDE26A",@"#E3BE72",@"#64B4E2",@"#ED8888",@"#7FE1E4",@"#A4E55C",@"#ECCA81",@"#EA87C6",@"#9899B3",@"#A99182",@"#71D6B4",@"#FFB39B",@"#AAACED",@"#E9B06E",@"#CDE26A",@"#E3BE72",@"#64B4E2",@"#ED8888",@"#7FE1E4",@"#A4E55C",@"#ECCA81",@"#EA87C6",@"#9899B3",@"#A99182",@"#71D6B4",@"#FFB39B",@"#AAACED",@"#E9B06E",@"#CDE26A",@"#E3BE72",@"#64B4E2",@"#ED8888"];
    }

    return _colorArr;
}
@end
