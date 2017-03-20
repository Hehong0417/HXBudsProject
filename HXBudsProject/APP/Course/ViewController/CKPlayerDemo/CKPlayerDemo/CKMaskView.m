//
//  CKMaskView.m
//  CKPlayerDemo
//
//  Created by n on 2017/3/16.
//  Copyright © 2017年 n. All rights reserved.
//

#import "CKMaskView.h"
#import "Masonry.h"


//进度条颜色
#define ProgressColor     [UIColor colorWithRed:0.54118 green:0.51373 blue:0.50980 alpha:1.00000]
//缓冲颜色
#define ProgressTintColor [UIColor orangeColor]
//播放完成颜色
#define PlayFinishColor   [UIColor whiteColor]

@interface CKMaskView ()

/**
 slider 左边默认颜色
 */


@end


@implementation CKMaskView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self initViews];
    }


    return self;
}
- (void)initViews{

    [self addSubview:self.topToolBar];
    [self addSubview:self.bottomToolBar];
//    [self addSubview:self.activity];
    [self.topToolBar addSubview:self.backButton];
    [self.bottomToolBar addSubview:self.fullScreenButton];
    [self.bottomToolBar addSubview:self.playButton];
    [self.bottomToolBar addSubview:self.currentTimeLabel];
    [self.bottomToolBar addSubview:self.totalTimeLabel];
    [self.bottomToolBar addSubview:self.progress];
    [self.bottomToolBar addSubview:self.slider];
    [self addSubview:self.failButton];
    [self makeConstraints];
    
    self.topToolBar.backgroundColor = [UIColor colorWithRed:0.00000f green:0.00000f blue:0.00000f alpha:0.50000f];
    self.bottomToolBar.backgroundColor = [UIColor colorWithRed:0.00000f green:0.00000f blue:0.00000f alpha:0.50000f];
}
- (void)makeConstraints{

    [self.topToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(50);
        
    }];
    [self.bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(50);
        
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-10);
        make.width.equalTo(self.backButton.mas_height);
    }];
//    //转子
//    [self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//    }];
    //失败按钮
    [self.failButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];

   [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.left.mas_equalTo(10);
       make.bottom.mas_equalTo(-10);
       make.width.equalTo(self.backButton.mas_height);
       
   }];
    //全屏按钮
    [self.fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.width.equalTo(self.backButton.mas_height);
    }];
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playButton.mas_right).offset(10);
        make.width.mas_equalTo(35);
        make.centerY.equalTo(self.bottomToolBar);
        
    }];
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.fullScreenButton.mas_left).offset(-10);
        make.width.mas_equalTo(35);
        make.centerY.equalTo(self.bottomToolBar);
        
    }];
    //缓冲条
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentTimeLabel.mas_right).offset(10);
        make.right.equalTo(self.totalTimeLabel.mas_left).offset(-10);
        make.height.mas_equalTo(2);
        make.centerY.equalTo(self.bottomToolBar);
    }];
    //滑杆
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.progress);
    }];
}
#pragma mark -- 按钮点击事件

//播放、暂停按钮
- (void)playButtonAction:(UIButton *)playButton {

    playButton.selected = !playButton.selected;
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(ck_playButtonAction:)]) {
        
        [self.delegate ck_playButtonAction:playButton];
    }
}
//返回按钮
- (void)backButtonAction:(UIButton *)backButton{

    backButton.selected = !backButton.selected;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(ck_backButtonAction:)]) {
        [self.delegate ck_backButtonAction:backButton];
    }

}
//全屏按钮
- (void)fullScreenButtonAction:(UIButton *)button{

    button.selected = !button.selected;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(ck_fullScreenButtonAction:)]) {
        [self.delegate ck_fullScreenButtonAction:button];
    }
}

#pragma mark -- slider 拖拽事件

//开始拖拽
- (void)sliderDragBegin:(CKSlider *)slider{

    if (self.delegate&&[self.delegate respondsToSelector:@selector(ck_sliderDragBeginAction:)]) {
        [self.delegate ck_sliderDragBeginAction:slider];
    }
}
//拖拽中
- (void)sliderDragChange:(CKSlider *)slider{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(ck_sliderDragChangeAction:)]) {
        [self.delegate ck_sliderDragChangeAction:slider];
    }

}
//拖拽完成
- (void)sliderDragEnd:(CKSlider *)slider{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(ck_sliderDragEndAction:)]) {
        [self.delegate ck_sliderDragEndAction:slider];
    }
}

#pragma mark -- 懒加载

- (UIView *)topToolBar {

    if (!_topToolBar) {
        
        _topToolBar = [[UIView alloc]init];
        _topToolBar.backgroundColor = [UIColor redColor];
    }

    return _topToolBar;
}
- (UIView *)bottomToolBar {
    
    if (!_bottomToolBar) {
        _bottomToolBar = [[UIView alloc]init];
    }
    return _bottomToolBar;
}
//转子
- (UIActivityIndicatorView *) activity{
    if (_activity == nil){
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_activity startAnimating];
    }
    return _activity;
}
//加载失败按钮
- (UIButton *) failButton
{
    if (_failButton == nil) {
        _failButton = [[UIButton alloc] init];
        _failButton.hidden = YES;
        [_failButton setTitle:@"加载失败,点击重试" forState:UIControlStateNormal];
        [_failButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _failButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _failButton.backgroundColor = [UIColor colorWithRed:0.00000f green:0.00000f blue:0.00000f alpha:0.50000f];
        [_failButton addTarget:self action:@selector(failButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _failButton;
}

- (UIButton *)playButton {

    if (!_playButton) {
        _playButton = [[UIButton alloc]init];
        [_playButton setImage:[self getPictureWithName:@"CLPlayBtn"] forState:UIControlStateNormal];
        [_playButton setImage:[self getPictureWithName:@"CLPauseBtn"] forState:UIControlStateSelected];
        [_playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
  return   _playButton;
}

- (CKSlider *)slider {
    if (!_slider) {
        _slider = [[CKSlider alloc]init];
        [_slider addTarget:self action:@selector(sliderDragBegin:) forControlEvents:UIControlEventTouchDown];
        [_slider addTarget:self action:@selector(sliderDragChange:) forControlEvents:UIControlEventValueChanged];
        [_slider addTarget:self action:@selector(sliderDragEnd:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
        
    }

    return _slider;

}
//缓冲条
- (UIProgressView *) progress{
    if (_progress == nil){
        _progress = [[UIProgressView alloc] init];
        _progress.trackTintColor = ProgressColor;
        _progress.progressTintColor = ProgressTintColor;
    }
    return _progress;
}
- (UIButton *)backButton {

    if (!_backButton) {
        
        _backButton = [[UIButton alloc]init];
        [_backButton setImage:[self getPictureWithName:@"CLBackBtn"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _backButton;
    
}
- (UIButton *)fullScreenButton {

    if (!_fullScreenButton) {
        _fullScreenButton = [[UIButton alloc]init];
        [_fullScreenButton setImage:[self getPictureWithName:@"CLMaxBtn"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[self getPictureWithName:@"CLMinBtn"] forState:UIControlStateSelected];
        [_fullScreenButton addTarget:self action:@selector(fullScreenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}
- (UILabel *)currentTimeLabel {
    if (!_currentTimeLabel) {
        _currentTimeLabel = [[UILabel alloc]init];
        _currentTimeLabel.text = @"00:00";
    }
    return _currentTimeLabel;
}
- (UILabel *)totalTimeLabel {

    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc]init];
        _totalTimeLabel.text = @"00:00";
    }
    return _totalTimeLabel;
}
- (UIImage *)getPictureWithName:(NSString *)name{
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"CKPlayer" ofType:@"bundle"]];
    NSString *path = [bundle pathForResource:name ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    return image;
}

@end
