//
//  HXHomePerformanceActivityCell.h
//  HXBudsProject
//
//  Created by n on 2017/2/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HXHomePerformanceCellDelegate <NSObject>

- (void)selectImageWithIndex:(NSInteger)index;

@end

//******* 主页(演出活动)和机构主页(机构老师)的cell*********//


@interface HXHomePerformanceActivityCell : UITableViewCell<UIScrollViewDelegate>


@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) NSArray *dataArr;

@property(nonatomic,strong) UIImageView *imageV;

@property(nonatomic,weak) id<HXHomePerformanceCellDelegate> delegate;


- (void)setDataArr:(NSArray *)dataArr rowMargin:(CGFloat) rowM imageV_W:(CGFloat)imageV_w imagV_H:(CGFloat)imagV_h  radius:(CGFloat)radius textColor:(UIColor *)textColor font:(UIFont *)font;

@end
