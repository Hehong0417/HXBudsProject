//
//  HXYourLikeCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXYourLikeCell.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"

@interface HXYourLikeCell ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,UIScrollViewDelegate>

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation HXYourLikeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        for (int index = 1; index < 4; index++) {
            
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%02d",index]];
            
            [self.imageArray addObject:image];
            
        }

        [self setupUI];
        
    }

    return self;

}
//

- (void)setupUI {

    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 8, SCREEN_WIDTH, WidthScaleSize_H(220))];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.6;
    pageFlowView.minimumPageScale = 0.9;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    pageFlowView.isOpenAutoScroll = NO;
    
    UIScrollView *bottomscrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(220))];
    bottomscrollView.backgroundColor = kWhiteColor;
    
    [bottomscrollView addSubview:pageFlowView];

    [pageFlowView reloadData];

    [self.contentView addSubview:bottomscrollView];

}
#pragma mark NewPagedFlowView Delegate

- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    
    return CGSizeMake(SCREEN_WIDTH - 84, WidthScaleSize_H(200));
    
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
    
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 84,WidthScaleSize_H(200))];
    }
    //在这里下载网络图片
    //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    bannerView.mainImageView.image = self.imageArray[index];
    
    NSString *text = @"￥80";
    
   NSMutableAttributedString *attriStr =  [text handleWithTextStr:text color:nil font:FONT(12) range:NSMakeRange(0, 1)];
    
    bannerView.priceLab.attributedText = attriStr;
    
    
    return bannerView;
}



#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
        
            }
    return _imageArray;
}
@end
