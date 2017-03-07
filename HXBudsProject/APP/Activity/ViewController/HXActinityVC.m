//
//  HXActinityVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/7.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXActinityVC.h"
#import "SGSegmentedControl.h"
#import "HXActivityOneVC.h"
#import "HXActivityTwoVC.h"
#import "HXActivityThreeVC.h"

@interface HXActinityVC ()<UIScrollViewDelegate,SGSegmentedControlDelegate>
@property(nonatomic,strong)SGSegmentedControl *SG;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@end

@implementation HXActinityVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    if (self.isHomeEntrance) {
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[UIButton lh_buttonWithFrame:CGRectMake(0, 0, 40, 40) target:self action:@selector(backAction) image:kImageNamed(@"back")]];
    }
    
    
    self.navigationItem.titleView = [UILabel lh_labelWithFrame:CGRectMake(0, 0, 50, 44) text:@"活动专区" textColor:kWhiteColor font:FONT(20) textAlignment:NSTextAlignmentCenter backgroundColor:kClearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    [self setupSegmentedControl];


}
- (void)backAction{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupSegmentedControl {
    
    NSArray *title_arr = @[@"演出音乐会", @"艺术比赛", @"考级报名"];
    
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
    self.SG.titleColorStateSelected = kRedColor;
    self.SG.indicatorColor = kRedColor;
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
    
    // 演出音乐会
    HXActivityOneVC *oneVC = [[HXActivityOneVC alloc] init];
    [self addChildViewController:oneVC];
    
    // 艺术比赛
    HXActivityTwoVC *twoVC = [[HXActivityTwoVC alloc] init];
    [self addChildViewController:twoVC];
    
    // 考级报名
    HXActivityThreeVC *threeVC = [[HXActivityThreeVC alloc] init];
    [self addChildViewController:threeVC];
    
    
    
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
