//
//  HXTabControl.m
//  HXBudsProject
//
//  Created by n on 2017/5/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXTabControl.h"
#import "HXTabControlCell.h"


@interface HXTabControl ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation HXTabControl

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 16, 100, 25)];
        titleLab.text = @"充值金额";
        [self addSubview:titleLab];
        self.moneyArr = @[@"20",@"50",@"100",@"200",@"300",@"500"];
        self.collectionView.frame = CGRectMake(0, 41, SCREEN_WIDTH, frame.size.height - 41);
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = kWhiteColor;
        [self addSubview:_collectionView];
        [self.collectionView registerClass:[HXTabControlCell class] forCellWithReuseIdentifier:@"HXTabControlCell"];
    }

    return self;
}
- (UICollectionView *)collectionView {

    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 6;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH - 2*50 - 2*25)/3, 35);
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    HXTabControlCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXTabControlCell" forIndexPath:indexPath];
    [cell lh_setCornerRadius:5 borderWidth:1 borderColor:APP_COMMON_COLOR];
    cell.moneyLab.text = [NSString stringWithFormat:@"￥%@",self.moneyArr[indexPath.row]] ;
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 25, 10, 25);
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    HXTabControlCell *cell = (HXTabControlCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = APP_COMMON_COLOR;
    cell.moneyLab.textColor = kWhiteColor;
    if (self.selectTabControlBlock) {
        self.selectTabControlBlock(self.moneyArr[indexPath.row]);
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {

    HXTabControlCell *cell = (HXTabControlCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = kWhiteColor;
    cell.moneyLab.textColor = APP_COMMON_COLOR;
}

@end
