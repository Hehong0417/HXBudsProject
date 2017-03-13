//
//  HXCourseDetailAnotherVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/1.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseDetailAnotherVC.h"
#import "SGSegmentedControl.h"
#import "HXCourseDetailOneVC.h"
#import "HXCourseDetailTwoVC.h"
#import "HXCourseDetailThreeVC.h"
#import "HXBuyBottomView.h"
#import <AFNetworking.h>
#import "CLPlayerView.h"


@interface HXCourseDetailAnotherVC ()<UIScrollViewDelegate,SGSegmentedControlDelegate>{
    

}
@property(nonatomic,strong)SGSegmentedControl *SG;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property(nonatomic,strong) UIView *headView;
@property(nonatomic,strong) HXBuyBottomView *buyBottomView;
@property(nonatomic,strong) UIImageView *playImgV;
@end

static CGFloat const headViewHeight = WidthScaleSize_H(200);


@implementation HXCourseDetailAnotherVC

- (BOOL)shouldAutorotate{

    return NO;
}
// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];


    self.navigationItem.titleView = [UILabel lh_labelWithFrame:CGRectMake(0, 0, 50, 44) text:@"课程详情" textColor:kWhiteColor font:FONT(20) textAlignment:NSTextAlignmentCenter backgroundColor:kClearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.headView];
    
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    [self setupSegmentedControl];

}

- (void)setupSegmentedControl {
    
    NSArray *title_arr = @[@"介绍", @"目录", @"评价"];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, headViewHeight + WidthScaleSize_H(44), self.view.frame.size.width, self.view.frame.size.height);
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
    
    
    
    self.SG = [SGSegmentedControl segmentedControlWithFrame:CGRectMake(0, headViewHeight, self.view.frame.size.width, WidthScaleSize_H(44)) delegate:self segmentedControlType:(SGSegmentedControlTypeStatic) titleArr:title_arr];
    self.SG.titleColorStateNormal = [UIColor colorWithHexString:@"#2D6B6D"];
    self.SG.titleColorStateSelected = APP_COMMON_COLOR;
    self.SG.indicatorColor = APP_COMMON_COLOR;
    [self.view addSubview:_SG];
    [self.view addSubview:self.buyBottomView];

    
    [self.playImgV bk_whenTapped:^{
        
        //*****播放器*****//
        
        CLPlayerView *playerView = [[CLPlayerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headViewHeight)];
        
        playerView.url = [NSURL URLWithString:self.URLString];
        [self.view addSubview:playerView];
        
        //**********//

        
    }];
    
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
    
    HXCourseDetailOneVC *oneVC = [[HXCourseDetailOneVC alloc] init];
    [self addChildViewController:oneVC];
    
    // 电视剧
    HXCourseDetailTwoVC *twoVC = [[HXCourseDetailTwoVC alloc] init];
    [self addChildViewController:twoVC];
    
    // 电影
    HXCourseDetailThreeVC *threeVC = [[HXCourseDetailThreeVC alloc] init];
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
    
- (UIView *)headView{
    
    if (!_headView) {
        _headView = [UIView lh_viewWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,headViewHeight) backColor:kWhiteColor];
        
        UIImageView *imageV =  [UIImageView lh_imageViewWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,headViewHeight) image:[UIImage imageNamed:@"04"]];
        self.playImgV = [UIImageView lh_imageViewWithFrame:CGRectMake(0, 0, 80, 80) image:[UIImage imageNamed:@"play"] userInteractionEnabled:YES];
        self.playImgV.center = imageV.center;
        self.playImgV.contentMode = UIViewContentModeCenter;
        [_headView addSubview:imageV];
        [_headView addSubview:self.playImgV];
    }
    
    
    return _headView;
    
}

- (HXBuyBottomView *)buyBottomView {
    
    if (!_buyBottomView) {
        
        _buyBottomView = [[HXBuyBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - WidthScaleSize_H(49) - 64 , SCREEN_WIDTH, WidthScaleSize_H(49))];
    }
    return _buyBottomView;
    
}
    
@end
