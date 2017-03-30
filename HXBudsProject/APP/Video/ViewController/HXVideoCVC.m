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


@interface HXVideoCVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;
@end

@implementation HXVideoCVC

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"视频";
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:layout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HXvideoCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HXvideoCollectionCell"];
    [self.collectionView registerClass:[HXVideoSectionHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HXVideoSectionHead"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = kWhiteColor;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HXvideoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXvideoCollectionCell" forIndexPath:indexPath];
     NSArray *imagNameArr = @[@"video_01",@"video_02",@"video_03",@"video_04"];
    cell.videoImagV.image = [UIImage imageNamed:imagNameArr[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH - 20 - 15)/2, 160);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

  return   CGSizeMake(SCREEN_WIDTH, WidthScaleSize_H(35));

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if (kind  == UICollectionElementKindSectionHeader) {
       
        ContentType contentType;
        NSString *imageName;
        NSString *titleName;
        NSString *headTitle;
        
        if (indexPath.section == 0) {
            headTitle = @"  专题视频";
            contentType = LeftImageRightTitle;
            titleName = @"更多》";
        }
        
        if (indexPath.section == 1) {
            headTitle = @"  艺术教程";
            contentType = LeftImageRightTitle;
            imageName = @"";
            titleName = @"更多》";
            
        }
        HXVideoSectionHead *sectionHead = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HXVideoSectionHead" forIndexPath:indexPath];
        sectionHead.headtitle = headTitle;
        sectionHead.discribText = @"为你的梦想保驾护航";
        sectionHead.rightBtnTitle = titleName;
        sectionHead.contentType = contentType;
        sectionHead.imageName = imageName;
        sectionHead.labFont = 14;
        FontAttributes *attrbutes = [FontAttributes fontAttributesWithFontColor:FontLightGrayColor fontsize:14];
        sectionHead.btnFontAttributes = attrbutes;
        [sectionHead setTapActionWithBlock:^{
            [self rightBtnActionWithSection:indexPath.section];
        }];    
        
        return sectionHead;
        
    }
    
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    HXCourseDetailAnotherVC *courseVC = [HXCourseDetailAnotherVC new];
   
    [self.navigationController pushVC:courseVC];
}
#pragma mark --- sectionHead delegate

- (void)rightBtnActionWithSection:(NSInteger)section {
    
        HXSubjectVideoVC *vc = [HXSubjectVideoVC new];
        
        [self.navigationController pushVC:vc];
    
}


@end
