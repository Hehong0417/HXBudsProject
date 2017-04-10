//
//  HXSearchSubjectVC.m
//  HXBudsProject
//
//  Created by n on 2017/4/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSearchSubjectVC.h"

#define PYTextColor RGB(113, 113, 113) // 文本字体颜色
#define PYMargin 10

#define  PYRectangleTagMaxCol 3

@interface HXSearchSubjectVC ()

@end

@implementation HXSearchSubjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UILabel *titleLabel = [UILabel lh_labelWithFrame:CGRectMake(15, 10, 150, 35) text:@"搜索结果" textColor:PYTextColor font:FONT(13) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
    [self.view addSubview:titleLabel];
    
    // 创建热门搜索标签容器
    UIView *contentView = [UIView lh_viewWithFrame:CGRectMake(15, 45, SCREEN_WIDTH-40, SCREEN_HEIGHT) backColor:kWhiteColor];
   
    [self addAndLayoutTagsWithTagsContentView:contentView tagTexts:self.searchResults];
    
    [self.view addSubview:contentView];
    
}
/**  添加和布局标签 */
- (NSArray *)addAndLayoutTagsWithTagsContentView:(UIView *)contentView tagTexts:(NSArray<NSString *> *)tagTexts;
{
    // 清空标签容器的子控件
    [contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 添加热门搜索标签
    NSMutableArray *tagsM = [NSMutableArray array];
    for (int i = 0; i < tagTexts.count; i++) {
        UILabel *label = [self labelWithTitle:tagTexts[i]];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [contentView addSubview:label];
        [tagsM addObject:label];
    }
    
    // 计算位置
    CGFloat currentX = 0;
    CGFloat currentY = 0;
    CGFloat countRow = 0;
    CGFloat countCol = 0;
    
    // 调整布局
    for (int i = 0; i < contentView.subviews.count; i++) {
        UILabel *subView = contentView.subviews[i];
        // 当搜索字数过多，宽度为contentView的宽度
        if (subView.mj_w > contentView.mj_w) subView.mj_w = contentView.mj_w;
        if (currentX + subView.mj_w + PYMargin * countRow > contentView.mj_w) { // 得换行
            subView.mj_x = 0;
            subView.mj_y = (currentY += subView.mj_h) + PYMargin * ++countCol;
            currentX = subView.mj_w;
            countRow = 1;
        } else { // 不换行
            subView.mj_x = (currentX += subView.mj_w) - subView.mj_w + PYMargin * countRow;
            subView.mj_y = currentY + PYMargin * countCol;
            countRow ++;
        }
    }
  
    return [tagsM copy];
}
/** 添加标签 */
- (UILabel *)labelWithTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.userInteractionEnabled = YES;
    label.font = [UIFont systemFontOfSize:12];
    label.text = title;
    label.textColor = [UIColor grayColor];
    label.backgroundColor = RGB(250, 250, 250);
    label.layer.cornerRadius = 3;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.mj_w += 20;
    label.mj_h += 14;
    return label;
}
- (void)tagDidCLick:(UITapGestureRecognizer *)tap{

    [self.navigationController popVC];

}

@end
