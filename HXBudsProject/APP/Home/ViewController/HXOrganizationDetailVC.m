
//
//  HXOrganizationDetailVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationDetailVC.h"

#import "HXMyLikeVC.h"
#import "SGSegmentedControl.h"
#import "HXMyArticleVC.h"
#import "HXCollectVC.h"
#import "HXMyAttetionVC.h"
#import "HXMyVideoVC.h"
#import "HXTeacherDetailAPI.h"
#import "HXTeacherDetailModel.h"
#import "HXOrganizationHeadView.h"

@interface HXOrganizationDetailVC ()<UIScrollViewDelegate,SGSegmentedControlDelegate>
@property(nonatomic,strong)SGSegmentedControl *SG;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *title_arr;
@property(nonatomic,assign) BOOL isMyHomeInfo;
@property (nonatomic, strong) HXTeacherDetailModel *teacherDetailModel;
@property (nonatomic, strong) HXHomeInfoArticleModel *homeInfoArticleModel;

@property (nonatomic, strong) HXSubjectVideoListModel *SubjectVideoListModel;
@property (nonatomic, strong) HXOrganizationHeadView *organizationHeadView;


@end

@implementation HXOrganizationDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.organizationHeadView = [HXOrganizationHeadView initOrganizationHeadViewWithXib];
    self.organizationHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    self.view.backgroundColor = kWhiteColor;
    self.organizationHeadView.nav = self.navigationController;
    [self.view addSubview:self.organizationHeadView];
    //关注
    [self.organizationHeadView.attentionBtn addTarget:self action:@selector(attentionBtnAction:) forControlEvents:UIControlStateNormal];
    
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    [self setupSegmentedControl];
    
    switch (self.detailType) {
        case teacherDetailType:{
          //名师详情
            [self getTeacherDetailData];
        }
            break;
        case organizationType:{
            //机构详情
            
        }
            break;
        default:
            break;
    }
    
}
- (void)getTeacherDetailData {
    
    [[[HXTeacherDetailAPI getTeacherDetailWithTeacherId:self.teacher_Id users_id:nil]netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        
        HXTeacherDetailModel *api = [HXTeacherDetailModel new];
        self.teacherDetailModel = [api.class mj_objectWithKeyValues:responseObject];
        
        self.organizationHeadView.pdModel = self.teacherDetailModel.pd;
        
    }];
    
}
- (void)attentionBtnAction:(UIButton *)button {

    

    if (self.isLogin) {
        
//        [self followRequestfollowed:followed];
  
    }else {
    
    
    
    }

}
//- (void)followRequest:(NSInteger )row followed:(BOOL)followed{
//    
//    
//    HXteacherVarListModel *model = self.teacherListModel.varList[row];
//    
//    [[[HXFollowAPI followTeacherWiththeteacherId:model.theteacher_id state:followed?@"1":@"0"] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
//        
//    }];
//    
//}

- (void)setupSegmentedControl {
    
    switch (self.detailType) {
        case organizationType:
            self.title_arr = @[@"课程列表",@"文章列表"];
            break;
        case teacherDetailType:
            self.title_arr = @[@"课程列表",@"文章列表",@"师资展示"];
            break;
        default:
            break;
    }
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 350, self.view.frame.size.width, self.view.frame.size.height- 300);
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
    
    
    self.SG = [SGSegmentedControl segmentedControlWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 44) delegate:self segmentedControlType:(SGSegmentedControlTypeStatic) titleArr:self.title_arr];
    self.SG.titleColorStateNormal = kBlackColor;
    self.SG.titleColorStateSelected = APP_COMMON_COLOR;
    self.SG.indicatorColor = APP_COMMON_COLOR;
    self.SG.title_fondOfSize = FONT(14);
//    self.SG.showsBottomScrollIndicator = NO;
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
        
        HXCollectVC *vc2 = [HXCollectVC new];
        
        [self addChildViewController:vc2];
    }
    
    switch (self.detailType) {
        case organizationType:{
            self.title_arr = @[@"课程列表",@"文章列表"];
        }
            break;
        case teacherDetailType:
            self.title_arr = @[@"课程列表",@"文章列表",@"师资展示"];
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
