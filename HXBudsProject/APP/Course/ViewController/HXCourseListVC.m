//
//  HXCourseListVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseListVC.h"
#import "SGSegmentedControl.h"
#import "HXCourseOneVC.h"
#import "HXCourseTwoVC.h"
#import "HXCourseThreeVC.h"
#import "HXCourseFourVC.h"
#import "HXCourseFiveVC.h"
#import "HXCourseSixVC.h"

@interface HXCourseListVC ()<UIScrollViewDelegate,SGSegmentedControlDelegate>

@property(nonatomic,strong)SGSegmentedControl *SG;
@property (nonatomic, strong) UIScrollView *mainScrollView;

@end

@implementation HXCourseListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.isHomeEntrance) {
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[UIButton lh_buttonWithFrame:CGRectMake(0, 0, 40, 40) target:self action:@selector(backAction) image:kImageNamed(@"back")]];
    }
    

    
    self.navigationItem.titleView = [UILabel lh_labelWithFrame:CGRectMake(0, 0, 50, 44) text:@"课程列表" textColor:kWhiteColor font:FONT(20) textAlignment:NSTextAlignmentCenter backgroundColor:kClearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    [self setupSegmentedControl];

}
- (void)setupSegmentedControl {
    
    NSArray *title_arr = @[@"器乐", @"舞蹈", @"绘画", @"媒体艺术", @"运动", @"武术"];
    
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
    
    
    
    self.SG = [SGSegmentedControl segmentedControlWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self segmentedControlType:(SGSegmentedControlTypeScroll) titleArr:title_arr];
    self.SG.titleColorStateNormal = [UIColor colorWithHexString:@"#2D6B6D"];
    self.SG.titleColorStateSelected = APP_COMMON_COLOR;
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
    // 精选
        
    HXCourseOneVC *oneVC = [[HXCourseOneVC alloc] init];
    [self addChildViewController:oneVC];
    
    // 电视剧 
    HXCourseTwoVC *twoVC = [[HXCourseTwoVC alloc] init];
   
    [self addChildViewController:twoVC];
    
    
    // 电影
    HXCourseThreeVC *threeVC = [[HXCourseThreeVC alloc] init];
    [self addChildViewController:threeVC];
    
    // 综艺
    HXCourseFourVC *fourVC = [[HXCourseFourVC alloc] init];
    [self addChildViewController:fourVC];
    
    // NBA
    HXCourseFiveVC *fiveVC = [[HXCourseFiveVC alloc] init];
    [self addChildViewController:fiveVC];
    
    // 新闻
    HXCourseSixVC *sixVC = [[HXCourseSixVC alloc] init];
    [self addChildViewController:sixVC];
    

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
