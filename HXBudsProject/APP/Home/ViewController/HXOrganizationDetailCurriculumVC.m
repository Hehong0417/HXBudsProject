//
//  HXOrganizationDetailCurriculumVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationDetailCurriculumVC.h"
#import "HXvideoCollectionCell.h"
@interface HXOrganizationDetailCurriculumVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HXOrganizationDetailCurriculumVC


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"课程列表";
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) collectionViewLayout:layout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HXChoicenessCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HXChoicenessCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = kWhiteColor;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = kWhiteColor;
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return 4;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HXvideoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXvideoCollectionCell" forIndexPath:indexPath];
    cell.videoIconImgV.hidden = YES;
    cell.teacherNameLab.hidden = YES;
//    cell.model = self.SubjectVideoListModel.varList[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH - 35)/2, 135);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return  CGSizeMake(SCREEN_WIDTH, 0.01);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
