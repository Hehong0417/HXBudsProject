//
//  HXOrganizationSGVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXFamousTeacherSGVC.h"
#import "SGSegmentedControl.h"
#import "HXFamousTeacherVC.h"

@interface HXFamousTeacherSGVC ()<UIScrollViewDelegate,SGSegmentedControlDelegate>
@property(nonatomic,strong)SGSegmentedControl *SG;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *title_arr;
@end

@implementation HXFamousTeacherSGVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"找名师";

    // 1.添加所有子控制器
    [self setupChildViewController];
    
    [self setupSegmentedControl];

}
- (void)setupSegmentedControl {
    
    self.title_arr = @[@"推荐名师",@"附近名师",@"全部"];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height- 44);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.title_arr.count, 0);
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    self.SG = [SGSegmentedControl segmentedControlWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self segmentedControlType:(SGSegmentedControlTypeStatic) titleArr:self.title_arr];
    self.SG.titleColorStateNormal = kBlackColor;
    self.SG.titleColorStateSelected = APP_COMMON_COLOR;
//    self.SG.showsBottomScrollIndicator = YES;
    self.SG.indicatorColor = APP_COMMON_COLOR;
    [self.view addSubview:_SG];
}


- (void)SGSegmentedControl:(SGSegmentedControl *)segmentedControl didSelectBtnAtIndex:(NSInteger)index {
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}
// 添加所有子控制器
- (void)setupChildViewController {
    
    for (NSInteger i = 0; i<3; i++) {
        
        HXFamousTeacherVC *vc = [HXFamousTeacherVC new];
        [self addChildViewController:vc];
    }

    
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    [self.SG titleBtnSelectedWithScrollView:scrollView];
}




@end
