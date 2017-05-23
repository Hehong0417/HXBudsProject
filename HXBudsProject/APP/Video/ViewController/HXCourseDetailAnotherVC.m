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
#import "HXpurchaseCourseAPI.h"
#import "WXApi.h"
#import "HXWXPayAPI.h"
#import "HXVideoCatalogueAPI.h"
#import "HXVideoCatalogueModel.h"

@interface HXCourseDetailAnotherVC ()<UIScrollViewDelegate,SGSegmentedControlDelegate,WXApiDelegate,CourseDetailTwoDelegate,NSCopying>{
    
    AFNetworkReachabilityManager *_Reachabilitymanager;
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
@property (nonatomic, strong) HXVideoCatalogueModel *catalogueModel;
@property (nonatomic, retain)NSString * URLString;
@property (nonatomic, strong)NSMutableArray * categoryArr;

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

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    //获取播放的目录和url
    
    
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
    
    [self getVideoCatalogueData];
}
- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    
    
    return copy;
}
- (NSMutableArray *)categoryArr{
    if (!_categoryArr) {
        _categoryArr = [NSMutableArray array];
    }
    return _categoryArr;
}
- (void)getVideoCatalogueData{
    
    [[[HXVideoCatalogueAPI getVideoCatalogueWithWithCurriculum_id:self.curriculum_id] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        HXVideoCatalogueModel *api = [HXVideoCatalogueModel new];
        self.catalogueModel = [api.class mj_objectWithKeyValues:responseObject];
        HXCataloguePdModel *model = self.catalogueModel.varList[0];
        self.URLString = model.videos_file;
        [self.categoryArr addObjectsFromArray:self.catalogueModel.varList];
//        NSLog(@"HXCataloguePdModel--%@",model);
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    
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
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self.videoDetailBgImageV sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(self.playImageStr)] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
  
    //加入学习
    [self AddSubscrib];
    
   
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
    
    
    //添加播放器
    NSLog(@"URLString--%@",self.URLString);


    WEAK_SELF();
    [self.playImgV setTapActionWithBlock:^{
        //**********播放器**************//
        if (weakSelf.IsAddSubscrib) {
          
         NSNumber *on =   [[NSUserDefaults standardUserDefaults] objectForKey:@"swi_State"];
            if (on.boolValue) {
           //仅在WIFI下
            //检测网络
            [weakSelf ReachabilityStatus:^(NSInteger status) {
                //继续
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"继续播放会关闭仅WIFI播放模式，播放会消耗流量" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:action1];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"继续播放" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@NO forKey:@"swi_State"];
                    weakSelf.playerView.url = [NSURL URLWithString:weakSelf.URLString];
                    weakSelf.playerView.vc = weakSelf;
                    [weakSelf.view addSubview:weakSelf.playerView];
                }];
                [alert addAction:action2];
                [weakSelf presentViewController:alert animated:YES completion:nil];
                
            }];
            }else{
             //4G下可播放
                weakSelf.playerView  = [[CLPlayerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headViewHeight)];
                weakSelf.playerView.url = [NSURL URLWithString:weakSelf.URLString];
                weakSelf.playerView.vc = weakSelf;
                [weakSelf.view addSubview:weakSelf.playerView];


            }

            //weakSelf.playerView.url = [NSURL URLWithString:@"http://yycloudvod2109130935.bs2dl.yy.com/djhmZjcyZTExZDRiZmY1Yzg0NzhlM2Q5MWVjZjRhYzY1MTUzNDQxMjM1Mg"];
           
        }else{
            
            [SVProgressHUD showInfoWithStatus:@"请先加入学习"];
            
        }
        //***************************//
        
    }];
    
}
- (void)ReachabilityStatus:(void(^)(NSInteger status))reachabilityStatus{

    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                
            case AFNetworkReachabilityStatusNotReachable:{
            
                NSLog(@"无网络");
                reachabilityStatus(0);
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                
                NSLog(@"WiFi网络");
                reachabilityStatus(1);

            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                
                NSLog(@"3G网络");
                reachabilityStatus(2);
                
            }
                break;
                
            default:
                
                break;
                
        }
        
    }];

}
- (void)AddSubscrib {

    //加入学习
    WEAK_SELF();
    self.buyBottomView.addSubscribeBlock = ^{
        //未加入且已登录
        if (!weakSelf.IsAddSubscrib&&weakSelf.isLogin) {
            
            //判断是否免费
            if (![weakSelf.charge_status_text isEqualToString:@"免费"]) {
                
                [weakSelf purchaseCourse:weakSelf.curriculum_price];
            }else{
                
                [[[HXSubscribeAddAPI addSubscribeWithcurriculum_id:weakSelf.curriculum_id] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
                    
                    weakSelf.buyBottomView.consultBtn.titleLabel.text = @"已加入";
                    weakSelf.IsAddSubscrib = YES;
                    weakSelf.buyBottomView.consultBtn.enabled = NO;
                }];
            }
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
//购买课程
- (void)purchaseCourse:(NSString *)curriculum_price{
    //后台支付接口
    [[[HXpurchaseCourseAPI purchaseCourseWithCurriculum_id:self.curriculum_id curriculum_price:self.curriculum_price] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        
        NSString *transaction = responseObject[@"pd"][@"transaction"];
        if ([transaction isEqualToString:@"ok"]) {
            //购买成功
            [[[HXSubscribeAddAPI addSubscribeWithcurriculum_id:self.curriculum_id] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
                
                self.buyBottomView.consultBtn.titleLabel.text = @"已加入";
                [SVProgressHUD showInfoWithStatus:@"加入成功"];
            }];
            
        }else if ([transaction isEqualToString:@"no"]){
            //余额不足，调用微信支付接口
            [[[HXWXPayAPI wxPayWithopcash:self.curriculum_price wxpaytype:@"APP"] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
                
                [self payWithResponse:responseObject];
            }];
        }else{
            
            [SVProgressHUD showInfoWithStatus:@"加入失败"];
        }
    }];


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
//            [self SGSegmentedControl:self.SG didSelectBtnAtIndex:1];
//            [self.SG titleBtnSelectedWithScrollView:self.mainScrollView];
            
        }else{
           //未加入
            self.IsAddSubscrib = NO;
            self.buyBottomView.consultBtn.titleLabel.text = @"加入学习";

        }
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
    
    twoVC.didselectBlock = ^(NSString *urlStr) {
        if (self.IsAddSubscrib) {
            [self.playerView destroyPlayer];
            self.playerView  = [[CLPlayerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headViewHeight)];
            self.URLString = urlStr;
            self.playerView.url = [NSURL URLWithString:urlStr];
            NSLog(@"url---%@",urlStr);
            self.playerView.vc = self;
            [self.view addSubview:self.playerView];
            
        }else{
        
            [SVProgressHUD showInfoWithStatus:@"请先加入学习"];
        
        }
     
    };
    
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

#pragma mark - CourseDetailTwoDelegate


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

- (void)payWithResponse:(NSDictionary *)response{
    
    PayReq * req = [[PayReq alloc] init];
    req.partnerId           = response[@"pd"][@"partner"];
    req.prepayId            = response[@"pd"][@"prepay_id"];
    req.nonceStr            = response[@"pd"][@"nonceStr"];
    NSString *timeStamp = response[@"pd"][@"timeStamp"];
    req.timeStamp           = timeStamp.intValue;
    req.package             = response[@"pd"][@"package"];
    req.sign                = response[@"pd"][@"finalsign"];
    BOOL success =  [WXApi sendReq:req];
    //日志输出
    NSLog(@"partid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\n sign=%@",req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    NSLog(@"success--%d",success);
    if (success) {
    
        [[[HXpurchaseCourseAPI purchaseCourseWithCurriculum_id:self.curriculum_id curriculum_price:self.curriculum_price] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
            
            NSString *transaction = responseObject[@"pd"][@"transaction"];
            if ([transaction isEqualToString:@"ok"]) {
                //加入学习
                [[[HXSubscribeAddAPI addSubscribeWithcurriculum_id:self.curriculum_id] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
                    
                    self.buyBottomView.consultBtn.titleLabel.text = @"已加入";
                    self.IsAddSubscrib = YES;
                    [SVProgressHUD showInfoWithStatus:@"加入成功"];
                }];
            }
            if (error) {
                [SVProgressHUD showInfoWithStatus:@"加入失败"];
            }
            
        }];
    }
}
//微信支付回调
- (void)onResp:(BaseResp *)resp  {
    
    
    
    
}

//分享到不同平台
- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType
{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建视频内容对象
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:self.model.curr_title descr:self.model.introduction  thumImage:kAPIImageFromUrl(self.model.curr_picture)];
    
    //设置视频网页播放地址
    shareObject.videoUrl = self.URLString;
    
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
//- (CLPlayerView *)playerView {
//
//    if (!_playerView) {
//        _playerView  = [[CLPlayerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headViewHeight)];
//    }
//    return _playerView;
//
//}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.playerView destroyPlayer];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.playerView destroyPlayer];

}
- (void)dealloc{

    [self.playerView destroyPlayer];

}

@end
