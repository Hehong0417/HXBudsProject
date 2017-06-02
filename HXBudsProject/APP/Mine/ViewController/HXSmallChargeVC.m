//
//  HXSmallChargeVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSmallChargeVC.h"
#import "SGSegmentedControl.h"
#import "HXReChargeRecordVC.h"
#import "HXDealRecordVC.h"


@interface HXSmallChargeVC ()<UIScrollViewDelegate,SGSegmentedControlDelegate>

@property(nonatomic,strong)SGSegmentedControl *SG;
@property (nonatomic, strong) UIScrollView *mainScrollView;@end

@implementation HXSmallChargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"零钱明细";
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    [self setupSegmentedControl];
}

- (void)setupSegmentedControl {
    
    
    NSArray *title_arr = @[@"提现记录",@"交易记录"];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * title_arr.count, 0);
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
    
    self.SG = [SGSegmentedControl segmentedControlWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self segmentedControlType:(SGSegmentedControlTypeStatic) titleArr:title_arr];
    self.SG.titleColorStateNormal = kBlackColor;
    self.SG.titleColorStateSelected = APP_COMMON_COLOR;
    self.SG.title_fondOfSize  = FONT(14);
    //    self.SG.showsBottomScrollIndicator = YES;
    self.SG.backgroundColor = KVCBackGroundColor;
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
    
    //提现记录
    HXReChargeRecordVC *vc1 = [HXReChargeRecordVC new];
    [self addChildViewController:vc1];
    
    //交易记录
    HXDealRecordVC *vc2 = [HXDealRecordVC new];
    [self addChildViewController:vc2];
 
    
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
