//
//  HXHomePerformanceActivityCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXHomePerformanceActivityCell.h"

@implementation HXHomePerformanceActivityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {


    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        //scrollView
        UIScrollView *scrollView =  [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(180))];
        _scrollView = scrollView;
        [self.contentView addSubview:_scrollView];
        
        
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr rowMargin:(CGFloat) rowM imageV_W:(CGFloat)imageV_w imagV_H:(CGFloat)imagV_h  radius:(CGFloat)radius  textColor:(UIColor *)textColor font:(UIFont *)font{

    NSInteger  scrollCount = dataArr.count;
    
    _scrollView.contentSize = CGSizeMake(scrollCount *(imageV_w + WidthScaleSize_W(20)) + WidthScaleSize_W(20) , WidthScaleSize_H(180));

    _scrollView.showsVerticalScrollIndicator = NO;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.bounces = NO;
    
    _scrollView.delegate = self;
    //imageView
    
    for (NSInteger i = 0; i < dataArr.count; i++) {
        
        CGFloat rowMargin = rowM;
        CGFloat imageV_W = imageV_w;
        CGFloat imagV_H = imagV_h;
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(rowMargin+(rowMargin + imageV_W)*i, WidthScaleSize_H(15), imageV_W, imagV_H)];
        [imageV lh_setCornerRadius:radius borderWidth:0 borderColor:kWhiteColor];
        imageV.image = [UIImage imageNamed:dataArr[i]];
        imageV.userInteractionEnabled = YES;
        [imageV setTapActionWithBlock:^{
            
            if ([self.delegate respondsToSelector:@selector(selectImageWithIndex:)]) {
                
                [self.delegate selectImageWithIndex:i];
            }

        }];
        
        [_scrollView addSubview:imageV];
        //y 150
        UILabel *titleLab = [UILabel lh_labelWithFrame:CGRectMake(rowMargin+(rowMargin + imageV_W)*i, imagV_H + WidthScaleSize_H(15), imageV_W, WidthScaleSize_H(30)) text:@"Sarah Bell" textColor:textColor font:font textAlignment:NSTextAlignmentCenter backgroundColor:kClearColor];
        [_scrollView addSubview:titleLab];
        
        
    }

}




//- (void)setDataArr:(NSArray *)dataArr {
//
//    _dataArr = dataArr;
//    
//    NSInteger  scrollCount = dataArr.count;
//    
//    _scrollView.contentSize = CGSizeMake(scrollCount *WidthScaleSize_W(196)+WidthScaleSize_W(20) , WidthScaleSize_H(180));
//    
//    _scrollView.showsVerticalScrollIndicator = NO;
//    
//    _scrollView.showsHorizontalScrollIndicator = NO;
//    
//    _scrollView.bounces = NO;
//
//    _scrollView.delegate = self;
//    //imageView
//    
//    for (NSInteger i = 0; i < dataArr.count; i++) {
//        
//        CGFloat rowMargin = WidthScaleSize_W(20);
//        CGFloat imageV_W = WidthScaleSize_W(176);
//        CGFloat imagV_H = WidthScaleSize_H(120);
//        
//        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(rowMargin+(rowMargin + imageV_W)*i, WidthScaleSize_H(15), imageV_W, imagV_H)];
//        [imageV lh_setCornerRadius:8 borderWidth:0 borderColor:kWhiteColor];
//        imageV.image = [UIImage imageNamed:dataArr[i]];
//        [_scrollView addSubview:imageV];
//        //y 150
//        UILabel *titleLab = [UILabel lh_labelWithFrame:CGRectMake(rowMargin+(rowMargin + imageV_W)*i, WidthScaleSize_H(140), imageV_W, WidthScaleSize_H(30)) text:@"萌芽钢琴分享会" textColor:FontGrayColor font:FONT(14) textAlignment:NSTextAlignmentCenter backgroundColor:kWhiteColor];
//        [_scrollView addSubview:titleLab];
//        
//        
//       
//        
//    }
//    
//}

@end
