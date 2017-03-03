//
//  HXTeacherListVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXTeacherListVC.h"
#import "HXTeacherBannerView.h"
#import "HXRecommendTeacherCell.h"
@interface HXTeacherListVC ()
@property(nonatomic,strong) UIView *bgview;
@end

@implementation HXTeacherListVC

- (void)loadView{

    
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [self.view addSubview:self.bgview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title = @"老师列表";
   self.automaticallyAdjustsScrollViewInsets = YES;
    
    if (self.isMyLike) {
        
        self.bgview.frame = CGRectMake(0, WidthScaleSize_H(44), SCREEN_WIDTH, SCREEN_HEIGHT - WidthScaleSize_H(44));
        
    }else {
        
        self.bgview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    
    }
    
    self.bgview.backgroundColor = kWhiteColor;
    
    NSArray *dataArr = @[@"01",@"02",@"03",@"04",@"05",@"01",@"02",@"03"];
    
    NSInteger lineCount = 3;
    
    for (NSInteger i = 0; i< dataArr.count; i++) {
        
        NSInteger line = i % lineCount;
        NSInteger row = i / lineCount;
        CGFloat imageV_W = WidthScaleSize_H(80);
        CGFloat imageV_H = WidthScaleSize_H(80);
        //列间距
        CGFloat lineMargin = (SCREEN_WIDTH - lineCount * imageV_W) / 6;
        //行间距
        CGFloat rowMargin = WidthScaleSize_H(20);
        
        CGFloat imageV_x = lineMargin + (lineMargin*2 + imageV_W)*line;
        
        CGFloat imageV_y = rowMargin + (rowMargin + imageV_H +WidthScaleSize_H(30))*row;
        
        UIImageView *imageV =  [[UIImageView alloc]initWithFrame:CGRectMake(imageV_x, imageV_y, imageV_W, imageV_H)];
        imageV.image = [UIImage imageNamed:dataArr[i]];
        [imageV lh_setCornerRadius:imageV_H/2 borderWidth:0 borderColor:kWhiteColor];
        
        
        //y 150
        UILabel *titleLab = [UILabel lh_labelWithFrame:CGRectMake(imageV_x, CGRectGetMaxY(imageV.frame), imageV_W, WidthScaleSize_H(30)) text:@"Sarah Bell" textColor:APP_COMMON_COLOR font:FONT(12) textAlignment:NSTextAlignmentCenter backgroundColor:kClearColor];
        
        [self.bgview addSubview:imageV];
        [self.bgview addSubview:titleLab];
        
        
    }
    

    
}


@end
