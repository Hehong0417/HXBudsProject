//
//  HXVideoCVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXVideoCVC.h"
#import "HXvideoCollectionCell.h"
#import "HXVideoSectionHead.h"
#import "HXCourseDetailAnotherVC.h"
#import "HXSubjectVideoVC.h"
#import "HXSubjectVideoAPI.h"
#import "HXSubjectVideoListModel.h"
#import "HXChoicenessCell.h"


@interface HXVideoCVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) HXSubjectVideoListModel *SubjectVideoListModel;
@property (nonatomic, strong) HXSubjectVideoListModel *ArtVideoListModel;

@end

@implementation HXVideoCVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //专题视频
    [self getSubjectVideoListWithCurriculum­­_status:nil completeHandle:^(id responseObject) {
        
        HXSubjectVideoListModel *api = [HXSubjectVideoListModel new];
        
        self.SubjectVideoListModel = [api.class mj_objectWithKeyValues:responseObject];
        NSLog(@"count---%ld",self.SubjectVideoListModel.varList.count);
        [self.collectionView reloadData];
        
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"视频";
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) collectionViewLayout:layout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HXChoicenessCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HXChoicenessCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = kWhiteColor;
    self.view.backgroundColor = KVCBackGroundColor;
    
}

- (void)getSubjectVideoListWithCurriculum­­_status:(NSString *)curriculum_status completeHandle:(void(^)(id responseObject))completeHandle {
    
    [[[HXSubjectVideoAPI getSubjectVideoWithLimit:@15 theteacherId:nil  curriculum­­_status:curriculum_status  isLogin:NO ] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        completeHandle(responseObject);
        
    }];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {


    return self.SubjectVideoListModel.varList.count;
        
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HXChoicenessCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXChoicenessCell" forIndexPath:indexPath];
    cell.model = self.SubjectVideoListModel.varList[indexPath.row];
    cell.nav = self.navigationController;
    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH - 20), 230);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

  return   CGSizeMake(SCREEN_WIDTH, 0.01);

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
    HXSubjectVideoModel *model = self.SubjectVideoListModel.varList[indexPath.row];
    vc.curriculum_id = model.curriculum_id;
    vc.playImageStr = model.curr_picture;
    vc.curriculum_price = model.curriculum_price;
    vc.charge_status_text = model.charge_status_text;
    vc.model = model;
    [self.navigationController pushVC:vc];
    
}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    if (kind  == UICollectionElementKindSectionHeader) {
//       
//        ContentType contentType;
//        NSString *imageName;
//        NSString *titleName;
//        NSString *headTitle;
//        
//        if (indexPath.section == 0) {
//            headTitle = @"  专题视频";
//            contentType = LeftImageRightTitle;
//            titleName = @"更多》";
//        }
//        
//        if (indexPath.section == 1) {
//            headTitle = @"  艺术教程";
//            contentType = LeftImageRightTitle;
//            imageName = @"";
//            titleName = @"更多》";
//            
//        }
//        HXVideoSectionHead *sectionHead = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HXVideoSectionHead" forIndexPath:indexPath];
//        sectionHead.headtitle = headTitle;
//        sectionHead.discribText = @"为你的梦想保驾护航";
//        sectionHead.rightBtnTitle = titleName;
//        sectionHead.contentType = contentType;
//        sectionHead.imageName = imageName;
//        sectionHead.labFont = 14;
//        FontAttributes *attrbutes = [FontAttributes fontAttributesWithFontColor:FontLightGrayColor fontsize:14];
//        sectionHead.btnFontAttributes = attrbutes;
//        [sectionHead setTapActionWithBlock:^{
//            
//            [self rightBtnActionWithSection:indexPath.section];
//            
//        }];    
//        
//        return sectionHead;
//        
//    }
//    
//    return nil;
//}

//#pragma mark --- sectionHead delegate
//
//- (void)rightBtnActionWithSection:(NSInteger)section {
//    
//    
//    HXSubjectVideoVC *vc = [HXSubjectVideoVC new];
//    if (section == 0) {
//        vc.videoTitle = @"艺术教程";
//        vc.curriculum­­_status = @"curriculum-status-ysjc";
//    }else {
//    
//        vc.videoTitle = @"专题视频";
//        vc.curriculum­­_status = @"curriculum-status-ztsp";
//
//    }
//    [self.navigationController pushVC:vc];
//    
//}


@end
