//
//  HXJXVideoCVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/19.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXJXVideoCVC.h"
#import "HXvideoCollectionCell.h"
#import "HXVideoSectionHead.h"
#import "HXCourseDetailAnotherVC.h"
#import "HXSubjectVideoVC.h"
#import "HXSubjectVideoAPI.h"
#import "HXSubjectVideoListModel.h"
#import "HXChoicenessCell.h"


@interface HXJXVideoCVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) HXSubjectVideoListModel *SubjectVideoListModel;
@property (nonatomic, strong) HXSubjectVideoListModel *ArtVideoListModel;

@end

@implementation HXJXVideoCVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //专题视频
    [self getSubjectVideoListWithCurriculum­­_status:@"recommend-status-jx" completeHandle:^(id responseObject) {
        
        HXSubjectVideoListModel *api = [HXSubjectVideoListModel new];
        
        self.SubjectVideoListModel = [api.class mj_objectWithKeyValues:responseObject];
        NSLog(@"count---%ld",self.SubjectVideoListModel.varList.count);
        [self.collectionView reloadData];
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"精选视频";
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 ) collectionViewLayout:layout];
    
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


@end