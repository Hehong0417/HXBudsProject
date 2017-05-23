//
//  HXTeacherGroupCourseVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXTeacherGroupCourseVC.h"
#import "HXCourseDetailAnotherVC.h"
#import "HXTeacherCourseCell.h"
#import "HXSubjectVideoAPI.h"
#import "HXSubjectVideoListModel.h"
#import "HXOrganizationCourseAPI.h"


@interface HXTeacherGroupCourseVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) HXSubjectVideoListModel *SubjectVideoListModel;

@end

@implementation HXTeacherGroupCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"课程列表";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-314) collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HXTeacherCourseCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HXTeacherCourseCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = kWhiteColor;
    self.view.backgroundColor = KVCBackGroundColor;
    switch (self.detailType) {
        case teacherDetailType:
            [self getTeacherVideoData];
            break;
        case organizationType:
            [self getOrganizationVideoData];
            break;
        default:
            break;
    }
    
}
- (void)getTeacherVideoData{
    
    [[[HXSubjectVideoAPI getSubjectVideoWithLimit:@20 theteacherId:nil curriculum­­_status:nil isLogin:NO] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        
        HXSubjectVideoListModel *api = [HXSubjectVideoListModel new];
        
        self.SubjectVideoListModel = [api.class mj_objectWithKeyValues:responseObject];
        [self.collectionView reloadData];
    }];
    
}
- (void)getOrganizationVideoData {
  
  [[[HXOrganizationCourseAPI getOrganizationVideoWithmechanism_id:self.mechanism_id Limit:@20] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
      HXSubjectVideoListModel *api = [HXSubjectVideoListModel new];
      
      self.SubjectVideoListModel = [api.class mj_objectWithKeyValues:responseObject];
      [self.collectionView reloadData];
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
    
    HXTeacherCourseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXTeacherCourseCell" forIndexPath:indexPath];

    cell.model = self.SubjectVideoListModel.varList[indexPath.row];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH - 35)/2, 165);
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
