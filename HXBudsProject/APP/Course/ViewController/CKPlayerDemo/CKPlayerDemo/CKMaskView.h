//
//  CKMaskView.h
//  CKPlayerDemo
//
//  Created by n on 2017/3/16.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKSlider.h"

@protocol CKMaskViewDelegate <NSObject>


/**
 暂停、播放按钮代理
 */
- (void)ck_playButtonAction:(UIButton *)playButton;

/**
 返回按钮代理
 */
- (void)ck_backButtonAction:(UIButton *)backButton;

/**
 全屏按钮代理
 */
- (void)ck_fullScreenButtonAction:(UIButton *)fullScreenButton;

/**
   slider 拖拽开始
 */
- (void)ck_sliderDragBeginAction:(CKSlider *)slider;
/**
 slider 拖拽中
 */
- (void)ck_sliderDragChangeAction:(CKSlider *)slider;
/**
 slider 拖拽完成
 */
- (void)ck_sliderDragEndAction:(CKSlider *)slider;


@end


@interface CKMaskView : UIView
/**
 顶部工具条
 */
@property(nonatomic,strong)UIView *topToolBar;
/**
 顶部返回按钮
 */
@property(nonatomic,strong)UIButton *backButton;
/**
 底部工具条
 */
@property(nonatomic,strong)UIView *bottomToolBar;
/**转子*/
@property (nonatomic,strong) UIActivityIndicatorView *activity;

/**
 底部播放按钮
 */
@property(nonatomic,strong)UIButton *playButton;
/**
 底部slider进度条
 */
@property(nonatomic,strong)CKSlider *slider;
/**加载失败按钮*/
@property (nonatomic,strong) UIButton *failButton;
/**缓冲进度条*/
@property (nonatomic,strong) UIProgressView *progress;
/**
 底部当前播放时间Label
 */
@property(nonatomic,strong)UILabel *currentTimeLabel;
/**
 底部视频总时间Label
 */
@property(nonatomic,strong)UILabel *totalTimeLabel;
/**
 底部全屏按钮
 */
@property(nonatomic,strong)UIButton *fullScreenButton;

/**
 slider 左边颜色
 */
@property(nonatomic,strong)UIColor *sliderLeftColor;

/**
 slider 右边颜色
 */
@property(nonatomic,strong)UIColor *sliderRightColor;

/**
 代理
 */
@property(nonatomic,copy)id <CKMaskViewDelegate> delegate;



@end
