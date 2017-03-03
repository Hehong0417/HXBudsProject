//
//  HXHomeCourseCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXHomeCourseCell.h"
#import "HXCourseListVC.h"

@implementation HXHomeCourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        NSArray *titleArr = @[@"钢琴",@"吉他",@"架子鼓",@"古筝",@"二胡",@"美术",@"国学",@"更多"];
        NSArray *imageArr = @[@"piano",@"guitar",@"drum",@"guzheng",@"erhu",@"arts",@"chineseStudy",@"more"];
        CGFloat rowMargin = WidthScaleSize_H(10);
        CGFloat lineMargin = WidthScaleSize_H(10);
        
        NSInteger num = 8;
        NSInteger LineNum = 4;
        for (NSInteger i = 0; i<num; i++) {
            
            NSInteger row = i / LineNum;
            NSInteger line = i % LineNum;
            CGFloat btnW = (SCREEN_WIDTH - 2*rowMargin)/4;
            CGFloat btnH = (WidthScaleSize_H(200) - 3*lineMargin)/2;
            XYQButton *btn = [XYQButton ButtonWithFrame:CGRectMake(rowMargin+line*btnW,lineMargin+row*(btnH+lineMargin), btnW, btnH) imgaeName:imageArr[i] titleName:titleArr[i] contentType:TopImageBottomTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:FontLightGrayColor fontsize:15]tapAction:^(XYQButton *button) {
                
                HXCourseListVC *courseVC = [HXCourseListVC new];
                
                [self.vc pushVC:courseVC];
                
            }];
            [self.contentView addSubview: btn];
        }
        
    }
    
    return self;
}
- (void)addSubViews{
    
    
    
}

@end
