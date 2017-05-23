//
//  HXHomeCVC.m
//  HXBudsProject
//
//  Created by n on 2017/4/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXHomeCVC.h"
#import "HXvideoCollectionCell.h"
#import "HXCourseDetailAnotherVC.h"
#import "HXTeacherCollectionCell.h"
#import "HXHomeReusableHeadView.h"
#import "HXVideoSectionHead.h"
#import "HXMyLikeVC.h"
#import "HXAdvertisementAPI.h"
#import "HXAdvListModel.h"
#import "HXteacherList.h"
#import "HXTeacherListModel.h"
#import "HXSubjectVideoAPI.h"
#import "HXSubjectVideoListModel.h"
#import "HXFollowAPI.h"
#import "HXIsLoginAPI.h"
#import "HXTeachingTypeListAPI.h"
#import "HXLoginVC.h"
#import "HXMesssageOneVC.h"
#import "HXSearchViewController.h"
#import "HXSearchVC.h"
#import "HXTeachingTypeListModel.h"
#import "HXChoicenessCell.h"
#import "HXCurriculumTypeCell.h"
#import "HXSectionFootView.h"
#import "HXCurriculumSearchAPI.h"
#import "HXSubjectVideoListModel.h"
#import "HXVideoCVC.h"
#import "HXSubjectVideoVC.h"
#import "HXJXVideoCVC.h"


@interface HXHomeCVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,SearchViewControllerDelegate>
{
     BOOL isLogin;
   
}
@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) HXAdvListModel *advertiseModel;
@property (nonatomic, strong) HXVarListModel *varListModel;
@property (nonatomic, strong) NSMutableArray *varListArr;

@property (nonatomic, strong) HXTeacherListModel *teacherListModel;
@property (nonatomic, strong) HXteacherVarListModel *teacherVarListModel;
@property (nonatomic, strong) HXSubjectVideoListModel *RmVideoListModel;
@property (nonatomic, strong) HXSubjectVideoListModel *JxVideoListModel;

@property (nonatomic, strong) HXTeachingTypeListModel *teachingTypeListModel;
@property (nonatomic, strong) NSArray *followList;

@property (nonatomic, strong) NSMutableArray *GroupArr;

@property (nonatomic, strong) HXSubjectVideoListModel *searchVideoModel;

@end

@implementation HXHomeCVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//     // 轮播图
//    [self getList_online];
//    //热门课程
//    [self getHotVideoList];
//    //精选好课
//    [self getFeaturedVideoList];
//
//    //课程类型
//    [self getTeachingTypeList];
    
       [self dispatchRequest];

}
- (void)dispatchRequest {
    
//    /创建信号量/
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    /创建全局并行/
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件A");
        //轮播图
        [self getList_online];
                dispatch_semaphore_signal(semaphore);

    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件B");
        //热门课程
        [self getHotVideoList];
        dispatch_semaphore_signal(semaphore);

    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件C");
        //精选好课
        [self getFeaturedVideoList];
        dispatch_semaphore_signal(semaphore);

    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件D");
        //精选好课
        [self getTeachingTypeList];
        dispatch_semaphore_signal(semaphore);

    });
    
    dispatch_group_notify(group, queue, ^{
//       /四个请求对应四次信号等待/
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"处理事件E");

    });
}

- (void)getTeachingTypeList{

    [[[HXTeachingTypeListAPI getTeachingTypeList] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        HXTeachingTypeListModel *api = [HXTeachingTypeListModel new];
        self.teachingTypeListModel = [api.class mj_objectWithKeyValues:responseObject];
//        dispatch_semaphore_signal(semaphore);
    }];

}

- (void)getList_online {
    
    [[[HXAdvertisementAPI getAdvertisement] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        HXAdvListModel *adv = [HXAdvListModel new];
        
        self.advertiseModel = [adv.class mj_objectWithKeyValues:responseObject];
        [self.varListArr removeAllObjects];
        for (HXVarListModel *model in self.advertiseModel.varList) {
            
         [self.varListArr addObject:kAPIImageFromUrl(model.picture)];
            
        }
//        dispatch_semaphore_signal(semaphore);

        [self.collectionView reloadData];
    }];

   
}
//热门课程
- (void)getHotVideoList{
    
    [[[HXSubjectVideoAPI getSubjectVideoWithLimit:@4 theteacherId:nil curriculum­­_status:@"recommend-status-rm" isLogin:NO] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        HXSubjectVideoListModel *api = [HXSubjectVideoListModel new];
        
        self.RmVideoListModel = [api.class mj_objectWithKeyValues:responseObject];
        [self.collectionView reloadData];
//        dispatch_semaphore_signal(semaphore);

    }];
    
}
//精选好课
- (void)getFeaturedVideoList {

    [self.GroupArr removeAllObjects];
    
    [[[HXSubjectVideoAPI getSubjectVideoWithLimit:@(10*self.page) theteacherId:nil curriculum­­_status:@"recommend-status-jx" isLogin:NO] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        HXSubjectVideoListModel *api = [HXSubjectVideoListModel new];
        
        self.JxVideoListModel = [api.class mj_objectWithKeyValues:responseObject];
        
        [self loadDataFinish:self.JxVideoListModel.varList];

        [self.collectionView reloadData];

    }];

}
/**
 *  加载数据完成
 */
- (void)loadDataFinish:(NSArray *)arr {
    
    // 添加数据
    if (self.page > 1) {
        
        [self.GroupArr addObjectsFromArray:arr];
    } else {
        
        self.GroupArr = arr.mutableCopy;
    }
    
    // 判断还有没有数据
//    if (arr.count == 0) {
//        
//        [SVProgressHUD showInfoWithStatus:@"暂无更多数据"];
//    }
//    
    
    BOOL noMoreData = (arr.count == 0 || arr.count < KpageSize);
    
    
    [self endRefreshing:noMoreData];
}

/**
 *  结束刷新
 */
- (void)endRefreshing:(BOOL)noMoreData {
    // 取消刷新
    if (self.collectionView.mj_header.isRefreshing) {
        [self.collectionView.mj_header endRefreshing];
    }
    else if (self.collectionView.mj_footer.isRefreshing) {
        [self.collectionView.mj_footer endRefreshing];
    }
    // 数据重载
    [self.collectionView reloadData];
    
}
#pragma mark - Setter_Getter
- (NSMutableArray *)GroupArr {
    if (!_GroupArr) {
        _GroupArr = [NSMutableArray array];
    }
    return _GroupArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self dispatchRequest];
    
    self.page = 1;
    
    UICollectionViewFlowLayout *flowout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 ) collectionViewLayout:flowout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = kWhiteColor;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HXvideoCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HXvideoCollectionCell"];
    [self.collectionView registerClass:[HXCurriculumTypeCell class] forCellWithReuseIdentifier:@"HXCurriculumTypeCell"];
//    [self.collectionView registerNib:[UINib nibWithNibName:@"HXTeacherCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HXTeacherCollectionCell"];
     [self.collectionView registerNib:[UINib nibWithNibName:@"HXChoicenessCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HXChoicenessCell"];

    [self.collectionView registerClass:[HXHomeReusableHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HXHomeReusableHeadView"];
    [self.collectionView registerClass:[HXVideoSectionHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HXVideoSectionHead"];
    [self.collectionView registerClass:[HXSectionFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HXSectionFootView"];
    
    self.view.backgroundColor = KVCBackGroundColor;
    [self addHeaderRefresh];
    [self addFooterRefresh];
    [self addSearchBtn];

}
- (void)addHeaderRefresh{

    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;

        [self getFeaturedVideoList];
    }];
    self.collectionView.mj_header = refreshHeader;

}

- (void)addFooterRefresh {
    
    MJRefreshAutoNormalFooter  *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getFeaturedVideoList];

    }];
    
    self.collectionView.mj_footer = refreshFooter;
    

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HXCurriculumTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCurriculumTypeCell" forIndexPath:indexPath];
        cell.nav = self.navigationController;
        return cell;
        
    }else if (indexPath.section == 1) {
        
        HXvideoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXvideoCollectionCell" forIndexPath:indexPath];
        cell.model = self.RmVideoListModel.varList[indexPath.row];
        cell.nav = self.navigationController;
        return cell;
  
    }else {
    
        HXChoicenessCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXChoicenessCell" forIndexPath:indexPath];
        cell.model = self.GroupArr[indexPath.row];
        cell.nav = self.navigationController;
        return cell;
    }
    
    return nil;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        
        return self.RmVideoListModel.varList.count;
        
    }else {
        
        return self.GroupArr.count;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return CGSizeMake(SCREEN_WIDTH - 20 , 180);
        
    }else if (indexPath.section == 1) {
        //195+35
        return CGSizeMake((SCREEN_WIDTH - 35)/2, 165);

//        return CGSizeMake(SCREEN_WIDTH , 100);
        
    }else{
        
    return CGSizeMake(SCREEN_WIDTH - 20, 230);
        
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return   CGSizeMake(SCREEN_WIDTH, WidthScaleSize_W(152)+85);

    }else {
    
        return  CGSizeMake(SCREEN_WIDTH, 35);
    }
    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {

    return  CGSizeMake(SCREEN_WIDTH, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
//      HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
//      HXSubjectVideoModel *model = self.RmVideoListModel.varList[indexPath.row];
//        vc.curriculum_id = model.curriculum_id;
//        [self.navigationController pushVC:vc];
       
        
    }else{
        
        HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
        HXSubjectVideoModel *model = self.JxVideoListModel.varList[indexPath.row];
        vc.curriculum_id = model.curriculum_id;
        vc.playImageStr = model.curr_picture;
        vc.curriculum_price = model.curriculum_price;
        vc.charge_status_text = model.charge_status_text;
        vc.model = model;
        [self.navigationController pushVC:vc];
    
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if (kind  == UICollectionElementKindSectionHeader) {
        
        if (indexPath.section == 0) {
            
            HXHomeReusableHeadView *sectionHead = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HXHomeReusableHeadView" forIndexPath:indexPath];
            
            sectionHead.imageURLStringsGroup = self.varListArr;
            sectionHead.nav = self.navigationController;
            return sectionHead;
        }else if(indexPath.section == 1){
            
            HXVideoSectionHead *sectionHead = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HXVideoSectionHead" forIndexPath:indexPath];
            sectionHead.headtitle = @"热门课程";
            sectionHead.contentType = LeftTitleRightImage;
            sectionHead.rightBtnTitle = @"更多";
            sectionHead.labFont = 15;
            sectionHead.imageName = @"hot";
            sectionHead.btnFontAttributes = [FontAttributes fontAttributesWithFontColor:RGB(186, 186, 186) fontsize:13];
            [sectionHead setTapActionWithBlock:^{
                HXSubjectVideoVC *vc = [HXSubjectVideoVC new];
                vc.videoTitle = @"热门视频";
                [self.navigationController pushVC:vc];
            }];
            return sectionHead;
        
        }else{
        
         HXVideoSectionHead *sectionHead = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HXVideoSectionHead" forIndexPath:indexPath];
            sectionHead.headtitle = @"精选好课";
            sectionHead.contentType = LeftTitleRightImage;
            sectionHead.rightBtnTitle = @"更多";
            sectionHead.labFont = 15;
            sectionHead.imageName = @"jingxuan";
            sectionHead.btnFontAttributes = [FontAttributes fontAttributesWithFontColor:RGB(186, 186, 186) fontsize:13];
            [sectionHead setTapActionWithBlock:^{
                HXJXVideoCVC *vc = [HXJXVideoCVC new];
                [self.navigationController pushVC:vc];

            }];
            return sectionHead;
        }
    }else if(kind  == UICollectionElementKindSectionFooter){
        HXSectionFootView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HXSectionFootView" forIndexPath:indexPath];
        return foot;
    }
    return nil;
}
- (NSMutableArray *)varListArr {
    if (!_varListArr) {
        _varListArr = [NSMutableArray array];
    }

    return _varListArr;
}
- (void)addSearchBtn{

    XYQButton *searchBtn = [XYQButton ButtonWithFrame:CGRectMake(0, 0, 44, 60) imgaeName:@"search" titleName:@"" contentType:LeftTitleRightImage buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kWhiteColor fontsize:14] tapAction:^(XYQButton *button) {
        
        [self addSearchVC];
    }];
    
    UIImage *image = [UIImage imageNamed:@"search"];
    [searchBtn setImage:image forState:UIControlStateNormal];
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    [searchBtn setTitleRectForContentRect:CGRectZero imageRectForContentRect:CGRectMake(-5, (searchBtn.lh_height-imageHeight)/2.0, imageWidth, imageHeight)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    
    XYQButton *messageBtn = [XYQButton ButtonWithFrame:CGRectMake(0, 0, 44, 60) imgaeName:@"mail" titleName:@"" contentType:LeftTitleRightImage buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kWhiteColor fontsize:14] tapAction:^(XYQButton *button) {
        
        //判断是否登录
        HJUser *user = [HJUser sharedUser];
        [[[HXIsLoginAPI isLoginWithToken:user.pd.token] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
            if (error) {
                [self.navigationController pushVC:[HXLoginVC new]];
            }
            NSString *isLoginStr = responseObject[@"pd"][@"islogin"];
            if ([isLoginStr isEqualToString:@"no"]) {
                isLogin = NO;
                [self.navigationController pushVC:[HXLoginVC new]];
            }else if([isLoginStr isEqualToString:@"yes"]){
                isLogin = YES;
                [self.navigationController pushVC:[HXMesssageOneVC new]];
            }
        }];

    }];
    UIImage *image2 = [UIImage imageNamed:@"mail"];
    [messageBtn setImage:image2 forState:UIControlStateNormal];
    CGFloat imageWidth2 = image2.size.width;
    CGFloat imageHeight2 = image2.size.height;
    [messageBtn setTitleRectForContentRect:CGRectZero imageRectForContentRect:CGRectMake(10, (messageBtn.lh_height-imageHeight)/2.0+5, imageWidth2, imageHeight2)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:messageBtn];
}
//搜索
- (void)addSearchVC{

    //*************搜 索************//
    // 1.创建热门搜索
    NSMutableArray *hotSeaches = [NSMutableArray array];
    NSMutableArray *hotSeaches_Ids = [NSMutableArray array];

    for (HXTeachingTypeVarListModel *model in self.teachingTypeListModel.varList) {
    
    [hotSeaches addObject:model.type_name];
    [hotSeaches_Ids addObject:model.teachingtype_id];
    }
    
    // 2. 创建控制器
    HXSearchViewController *searchViewController = [HXSearchViewController searchViewControllerWithHotSearches:hotSeaches hotSearches_ids:hotSeaches_Ids searchBarPlaceholder:@"搜索" didSearchBlock:^(HXSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
//        
//        [searchViewController.navigationController pushViewController:[[HXSearchVC alloc] init] animated:YES];
        
    }];
//3.设置风格
    searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleDefault;
    // 4. 设置代理
    searchViewController.delegate = self;
//    searchViewController.searchSuggestions = @[@"视频1",@"视频2"];
    
    [self.navigationController pushVC:searchViewController];
    
    //****************************//

}
#pragma mark - SearchViewControllerDelegate
- (void)searchViewController:(HXSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    
    if (searchText.length) { // 与搜索条件再搜索
        
        //标题模糊查询
        [[[HXCurriculumSearchAPI getsearchCurriculumListWithCurr_title:searchText teachingtype_id:nil]netWorkClient]postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
            HXSubjectVideoListModel *api = [HXSubjectVideoListModel new];
            self.searchVideoModel = [api.class mj_objectWithKeyValues:responseObject];
            searchViewController.searchSuggestions = self.searchVideoModel.varList;
        }];
        
       }
    
}

@end
