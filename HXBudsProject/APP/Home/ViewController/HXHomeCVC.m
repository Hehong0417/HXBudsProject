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
#import "HXSubjectVideoVC.h"
#import "HXMyLikeVC.h"
#import "HXHomeAPI.h"
#import "HXAdvertisementAPI.h"
#import "HXAdvListModel.h"

@interface HXHomeCVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) HXAdvListModel *advertiseModel;
@property (nonatomic, strong) HXVarListModel *varListModel;
@property (nonatomic, strong) NSMutableArray *varListArr;

@end

@implementation HXHomeCVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getList_online];
    [self getHomeInfoData];

}
- (void)getHomeInfoData{

//    [[[HXHomeAPI getHomeInfoWithPage:@(_page) rows:@10] netWorkClient]postRequestInView:self.view successBlock:^(id responseObject) {
//        
//         HXHomeAPI *api = responseObject;
//        
//    } ];

}
- (void)getList_online {
    
    [[[HXAdvertisementAPI getAdvertisement] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        
        HXAdvListModel *adv = [HXAdvListModel new];
        
        self.advertiseModel = [adv.class mj_objectWithKeyValues:responseObject];
        
        
        NSLog(@"responseObject:%@",responseObject);
        NSLog(@"advertiseModel:%@",self.advertiseModel.varList);
        
        for (HXVarListModel *model in self.advertiseModel.varList) {
            
            [self.varListArr addObject:kAPIImageFromUrl(model.picture)];
            
        }
        [self.collectionView reloadData];
    }];
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.page = 1;
    
    UICollectionViewFlowLayout *flowout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 ) collectionViewLayout:flowout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = kWhiteColor;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HXvideoCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HXvideoCollectionCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HXTeacherCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HXTeacherCollectionCell"];
    [self.collectionView registerClass:[HXHomeReusableHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HXHomeReusableHeadView"];
    [self.collectionView registerClass:[HXVideoSectionHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HXVideoSectionHead"];
    self.view.backgroundColor = kWhiteColor;
    
    [self addHeaderRefresh];
    [self addFooterRefresh];

}
- (void)addHeaderRefresh{

    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.collectionView.mj_header endRefreshing];

    }];
    self.collectionView.mj_header = refreshHeader;

}

- (void)addFooterRefresh {
    
    MJRefreshAutoNormalFooter  *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];

    }];
    
    self.collectionView.mj_footer = refreshFooter;
    

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HXTeacherCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXTeacherCollectionCell" forIndexPath:indexPath];
        NSArray *imagArr = @[@"testIcon",@"teacher2"];
        cell.imageName = imagArr[indexPath.row];
        return cell;
  
    }else {
    
        HXvideoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXvideoCollectionCell" forIndexPath:indexPath];
        NSArray *imagNameArr = @[@"video_01",@"video_02",@"video_03",@"video_04"];
        cell.videoImagV.image = [UIImage imageNamed:imagNameArr[indexPath.item]];
        cell.nav = self.navigationController;
        return cell;
    }
    
    return nil;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 2;
    }else {
        
    return 4;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return CGSizeMake(SCREEN_WIDTH , 100);
        
    }else{
        
    return CGSizeMake((SCREEN_WIDTH - 35)/2, 160);
        
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return   CGSizeMake(SCREEN_WIDTH, WidthScaleSize_W(152)+40);

    }else  if (section == 1) {
    
        return  CGSizeMake(SCREEN_WIDTH, 35);

    }
    return CGSizeMake(0, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HXMyLikeVC *vc = [HXMyLikeVC new];
        vc.titleStr = @"他的主页";
        [self.navigationController pushVC:vc];
    }else{
        
//        HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
//        [self.navigationController pushVC:vc];
    
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if (kind  == UICollectionElementKindSectionHeader) {
        
        if (indexPath.section == 0) {
            
            HXHomeReusableHeadView *sectionHead = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HXHomeReusableHeadView" forIndexPath:indexPath];
            
            sectionHead.imageURLStringsGroup = self.varListArr;

            sectionHead.headtitle = @"名师推荐";
            sectionHead.contentType = LeftImageRightTitle;
            sectionHead.rightBtnTitle = @"换一换";
            sectionHead.btnFontAttributes = [FontAttributes fontAttributesWithFontColor:RGB(186, 186, 186) fontsize:13];
            sectionHead.imageName = @"change";
            sectionHead.labFont = 15;
            sectionHead.discribText = @"为你的梦想保驾护航的人";
            [sectionHead.rightBtn setTapActionWithBlock:^{
                NSLog(@"换一换");
            }];
            return sectionHead;
        }else if (indexPath.section == 1){
        
         HXVideoSectionHead *sectionHead = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HXVideoSectionHead" forIndexPath:indexPath];
            sectionHead.headtitle = @"专题视频";
            sectionHead.contentType = LeftImageRightTitle;
            sectionHead.rightBtnTitle = @"更多 》";
            sectionHead.labFont = 15;
            sectionHead.discribText = @"为你找到志趣相投的人";
            sectionHead.btnFontAttributes = [FontAttributes fontAttributesWithFontColor:RGB(186, 186, 186) fontsize:13];
            [sectionHead setTapActionWithBlock:^{
                HXSubjectVideoVC *vc = [HXSubjectVideoVC new];
                [self.navigationController pushVC:vc];
            }];
            return sectionHead;
            
        }
    }
    return nil;
}
- (NSMutableArray *)varListArr {
    if (!_varListArr) {
        _varListArr = [NSMutableArray array];
    }

    return _varListArr;
}
@end
