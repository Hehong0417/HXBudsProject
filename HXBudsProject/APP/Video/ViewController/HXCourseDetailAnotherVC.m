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
#import "AFNetworking.h"
#import "CLPlayerView.h"
#import <UShareUI/UShareUI.h>
#import "HXSubscribeAddAPI.h"
#import "HXIsSubscribAddAPI.h"
#import "HXIsLoginAPI.h"
#import "HXLoginVC.h"
@interface HXCourseDetailAnotherVC ()<UIScrollViewDelegate,SGSegmentedControlDelegate>{
    
    
    
}
@property(nonatomic,assign)BOOL isLogin;
@property(nonatomic,assign)BOOL IsAddSubscrib;

@property(nonatomic,strong)SGSegmentedControl *SG;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property(nonatomic,strong) UIView *headView;
@property(nonatomic,strong) HXBuyBottomView *buyBottomView;
@property(nonatomic,strong) UIImageView *playImgV;
@property(nonatomic,strong) CLPlayerView *playerView;
@property(nonatomic,strong) UIImageView *videoDetailBgImageV;

@end

static CGFloat const headViewHeight = WidthScaleSize_H(200);


@implementation HXCourseDetailAnotherVC


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden{
//    if (isHiddenStatusBar) {//隐藏
//        return YES;
//    }
    return NO;
}
//视图控制器实现的方法
-(BOOL)shouldAutorotate{       //iOS6.0之后,要想让状态条可以旋转,必须设置视图不能自动旋转
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
   //判断是否已登录
    HJUser *user = [HJUser sharedUser];
    [[[HXIsLoginAPI isLoginWithToken:user.pd.token] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        
        NSString *isLoginStr = responseObject[@"pd"][@"islogin"];
        if ([isLoginStr isEqualToString:@"no"]) {
            self.isLogin = NO;
        }else {
            self.isLogin = YES;
            //判断是否已加入学习
            [self isSubcribeAdd];
        }
    }];
    
    
    self.navigationItem.titleView = [UILabel lh_labelWithFrame:CGRectMake(0, 0, 50, 44) text:@"课程详情" textColor:kBlackColor font:FONT(20) textAlignment:NSTextAlignmentCenter backgroundColor:kClearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.headView];
    
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    [self setupSegmentedControl];

    //收藏、赞赏
    self.buyBottomView.vc = self;
    [self.view addSubview:self.buyBottomView];
    
    
    //rightBarButton、分享按钮
    UIButton *rightBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 50, 50) target:self action:@selector(shareAction) image:[UIImage imageNamed:@"share"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self.videoDetailBgImageV sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(self.playImageStr)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
    //加入学习
    WEAK_SELF();
    self.buyBottomView.addSubscribeBlock = ^{
        //未加入且已登录
        if (!weakSelf.IsAddSubscrib&&weakSelf.isLogin) {
            [[[HXSubscribeAddAPI addSubscribeWithcurriculum_id:weakSelf.curriculum_id] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
                
                weakSelf.buyBottomView.consultBtn.titleLabel.text = @"已加入";
            }];
        }
        //未加入且未登录
        if (!weakSelf.IsAddSubscrib&&!weakSelf.isLogin) {
            
            [weakSelf.navigationController pushVC:[HXLoginVC new]];
        }
        //已加入
        if (weakSelf.IsAddSubscrib) {
            
           weakSelf.buyBottomView.consultBtn.enabled = NO;
        }
    };
    
    
}
//是否加入学习
- (void)isSubcribeAdd{

    [[[HXIsSubscribAddAPI IsSubscribWithcurriculum_id:self.curriculum_id] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
       
        NSString *statestr = responseObject[@"pd"][@"state"];
        NSInteger state = statestr.integerValue;
        if (state > 0) {
            //已加入
            self.IsAddSubscrib = YES;
            [self.buyBottomView.consultBtn setTitle:@"已加入" forState:UIControlStateNormal];
            
            self.buyBottomView.consultBtn.enabled = NO;

        }else{
           //未加入
            self.IsAddSubscrib = NO;
            self.buyBottomView.consultBtn.titleLabel.text = @"加入学习";

        }
    }];
}
- (void)setupSegmentedControl {
    
    NSArray *title_arr = @[@"简介", @"课时", @"评价"];
    
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
    _mainScrollView.showsVerticalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    
    self.SG = [SGSegmentedControl segmentedControlWithFrame:CGRectMake(0, headViewHeight, self.view.frame.size.width, WidthScaleSize_H(44)) delegate:self segmentedControlType:(SGSegmentedControlTypeStatic) titleArr:title_arr];
    self.SG.titleColorStateNormal = [UIColor blackColor];
    self.SG.titleColorStateSelected = APP_COMMON_COLOR;
    self.SG.indicatorColor = APP_COMMON_COLOR;
    [self.view addSubview:_SG];

    
    WEAK_SELF();
    [self.playImgV setTapActionWithBlock:^{
        //**********播放器**************//
        
        if (weakSelf.IsAddSubscrib) {
            weakSelf.playerView = [[CLPlayerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headViewHeight)];
            
            if (!weakSelf.URLString) {
                weakSelf.URLString = @"error";
            }

            weakSelf.playerView.url = [NSURL URLWithString: @"http://1253712797.vod2.myqcloud.com/e8f61ed3vodtransgzp1253712797/863fe8399031868222929787287/f0.f20.mp4"];
//            weakSelf.playerView.url = [NSURL URLWithString:@"http://yycloudvod2109130935.bs2dl.yy.com/djhmZjcyZTExZDRiZmY1Yzg0NzhlM2Q5MWVjZjRhYzY1MTUzNDQxMjM1Mg"];
            
            weakSelf.playerView.vc = weakSelf;
            [weakSelf.view addSubview:weakSelf.playerView];
        }else{
            
            [SVProgressHUD showInfoWithStatus:@"请先加入学习"];
            
        }
        //***************************//

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
    oneVC.curriculum_id = self.curriculum_id;
    [self addChildViewController:oneVC];
    
    // 电视剧
    HXCourseDetailTwoVC *twoVC = [[HXCourseDetailTwoVC alloc] init];
    twoVC.curriculum_id = self.curriculum_id;
    [self addChildViewController:twoVC];
    
    // 电影
    HXCourseDetailThreeVC *threeVC = [[HXCourseDetailThreeVC alloc] init];
    threeVC.curriculum_id = self.curriculum_id;
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
//分享
- (void)shareAction {
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        [self shareVedioToPlatformType:platformType];
        
    }];
    
}
//分享到不同平台
- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType
{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建视频内容对象
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"courseDetail"]];
    
    //设置视频网页播放地址
    shareObject.videoUrl = video_testUrl;
    
    //            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (UIView *)headView{
    
    if (!_headView) {
        _headView = [UIView lh_viewWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,headViewHeight) backColor:kWhiteColor];
        
        self.videoDetailBgImageV =  [UIImageView lh_imageViewWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,headViewHeight) image:[UIImage imageNamed:@"courseDetail"]];
        self.playImgV = [UIImageView lh_imageViewWithFrame:CGRectMake(0, 0, 80, 80) image:[UIImage imageNamed:@"play"] userInteractionEnabled:YES];
        self.playImgV.center = self.videoDetailBgImageV.center;
        self.playImgV.contentMode = UIViewContentModeCenter;
        [_headView addSubview:self.videoDetailBgImageV];
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    self.playerView = nil;

}


@end
