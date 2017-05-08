//
//  HXMyLikeVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyLikeVC.h"
#import "SGSegmentedControl.h"
#import "HXMyHomeHeadView.h"
#import "HXMyArticleVC.h"
#import "HXCollectVC.h"
#import "HXMyAttetionVC.h"
#import "HXMyVideoVC.h"
#import "HXTeacherDetailAPI.h"
#import "HXTeacherDetailModel.h"



@interface HXMyLikeVC ()<UIScrollViewDelegate,SGSegmentedControlDelegate>
{
    
    HXMyHomeHeadView  *mineHeadView;
    
}
@property(nonatomic,strong)SGSegmentedControl *SG;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property(nonatomic,assign) BOOL isMyHomeInfo;
@property (nonatomic, strong) HXTeacherDetailModel *teacherDetailModel;
@property (nonatomic, strong) HXHomeInfoArticleModel *homeInfoArticleModel;

@property (nonatomic, strong) HXSubjectVideoListModel *SubjectVideoListModel;
@property (nonatomic, strong) NSArray *title_arr;


@end

@implementation HXMyLikeVC

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
 
    //老师详情
    [self getTeacherDetailData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleStr;
    self.view.backgroundColor = kWhiteColor;
    
    switch (self.dynamicType) {
        case teacherDynamicType:{
            self.title_arr  = @[@"文章", @"视频"];
            self.isMyHomeInfo = NO;
        }
            break;
        case himDynamicType:{
            self.title_arr  = @[@"文章", @"收藏",@"关注"];
            self.isMyHomeInfo = NO;
        }
            break;
        case mineDynamicType:{
            self.title_arr  = @[@"文章", @"收藏",@"关注"];
            self.isMyHomeInfo = YES;
        }
            break;
        default:
            break;
    }
    mineHeadView = [HXMyHomeHeadView initMyHomeHeadViewWithXib];
    mineHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 224);
    mineHeadView.isMyHomeInfo = self.isMyHomeInfo;
    mineHeadView.nav = self.navigationController;
    
    [self.view addSubview:mineHeadView];
    
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    [self setupSegmentedControl];
    
    
}
- (void)getTeacherDetailData {

    [[[HXTeacherDetailAPI getTeacherDetailWithTeacherId:self.theteacher_id users_id:self.users_id]netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
       
        HXTeacherDetailModel *api = [HXTeacherDetailModel new];
        self.teacherDetailModel = [api.class mj_objectWithKeyValues:responseObject];

        mineHeadView.pdModel = self.teacherDetailModel.pd;

    }];

}

- (void)setupSegmentedControl {
    
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 204, self.view.frame.size.width, self.view.frame.size.height- 165);
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
    
    
    self.SG = [SGSegmentedControl segmentedControlWithFrame:CGRectMake(0, 160, self.view.frame.size.width, 44) delegate:self segmentedControlType:(SGSegmentedControlTypeStatic) titleArr:self.title_arr];
    self.SG.titleColorStateNormal = kBlackColor;
    self.SG.titleColorStateSelected = APP_COMMON_COLOR;
    self.SG.indicatorColor = kRedColor;
    self.SG.showsBottomScrollIndicator = NO;
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

    HXMyArticleVC *vc1 = [HXMyArticleVC new];
    
    HXCollectVC *vc2 = [HXCollectVC new];
    
    HXMyVideoVC *vc3 = [HXMyVideoVC new];
    
    HXMyAttetionVC *vc4 = [HXMyAttetionVC new];
    
    switch (self.dynamicType) {
        case teacherDynamicType:{
            vc1.articleType = teacherDynamicArticle;
            vc1.theteacher_id = self.theteacher_id;
            vc3.videoType = teacherVideo;
            
            [self addChildViewController:vc1];
            [self addChildViewController:vc3];
        }
            break;
        case himDynamicType:{
            vc1.articleType = himDynamicArticle;
            vc4.attentionType = dynamicType;
            [self addChildViewController:vc1];
            [self addChildViewController:vc2];
            [self addChildViewController:vc4];
        }
            break;
        case mineDynamicType:{
            vc1.articleType = mineDynamicArticle;
            vc4.attentionType = dynamicType;
            [self addChildViewController:vc1];
            [self addChildViewController:vc2];
            [self addChildViewController:vc4];
        }
            break;
        default:
            break;
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
