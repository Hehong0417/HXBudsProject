//
//  CKPlayerView.m
//  CKPlayerDemo
//
//  Created by n on 2017/3/16.
//  Copyright © 2017年 n. All rights reserved.
//

#import "CKPlayerView.h"
#import "CKMaskView.h"
#import <AVFoundation/AVFoundation.h>
#import "Masonry.h"


//播放器的几种状态
typedef enum : NSUInteger {
    CKPlayerStateFaild,
    CKPlayerStateBuffering,
    CKPlayerStatePlaying,
    CKPlayerStateStopped,
    CKPlayerStatePause
} CKPlayerState;


@interface CKPlayerView ()<CKMaskViewDelegate,NSCopying>

/**
 工具栏遮罩
 */
@property(nonatomic,strong) CKMaskView *maskView;
/**
 播放器
 */
@property(nonatomic,strong) AVPlayer *player;
/**
 播放器layer
 */
@property(nonatomic,strong) AVPlayerLayer *playerLayer;
/**
 播放器item
 */
@property(nonatomic,strong) AVPlayerItem *playerItem;

/**
 内置contentView
 */
@property(nonatomic,strong) UIView *contentView;


/** 播发器的几种状态 */
@property (nonatomic,assign) CKPlayerState state;


/**轻拍定时器*/
@property (nonatomic,strong) NSTimer          *timer;
/**slider定时器*/
@property (nonatomic,strong) NSTimer          *sliderTimer;


@end

@implementation CKPlayerView

#pragma mark -- 初始化

- (CKMaskView *)maskView {
    
    if (!_maskView) {
        _maskView = [[CKMaskView alloc]initWithFrame:self.bounds];
        _maskView.delegate = self;
    }
    
    return _maskView;
}
- (void)setUrl:(NSURL *)url {
    
    _url = url;
    
    self.playerItem = [AVPlayerItem playerItemWithAsset:[AVAsset assetWithURL:_url]];
    _player = [AVPlayer playerWithPlayerItem:self.playerItem];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    _playerLayer.videoGravity = AVLayerVideoGravityResize;
    self.player.usesExternalPlaybackWhileExternalScreenIsActive=YES;
    _playerLayer.frame = self.contentView.layer.bounds;
    [self.contentView.layer insertSublayer:_playerLayer atIndex:0];
    self.contentView.backgroundColor = [UIColor redColor];
    _playerLayer.backgroundColor = [UIColor orangeColor].CGColor;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
       [self creatUI];
    }
    
    
    return self;
}

- (void)creatUI{
    
    [self addSubview:self.contentView];
//
    [self.contentView addSubview:self.maskView];
    
    [self makeContraint];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.playerLayer.frame        = self.bounds;
    self.maskView.frame = self.bounds;
    self.contentView.frame = self.bounds;
}
- (void)makeContraint{

    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
        
    }];
    
    

}
#pragma mark -- action

//播放
- (void)play{
    
    self.maskView.playButton.selected = NO;

    [self.player play];
    
}
//暂停
- (void)pause{
    
    self.maskView.playButton.selected = YES;

    [self.player pause];
}


#pragma mark -- 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    
    if ([keyPath isEqualToString:@"status"]) {
        
        if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
            
            NSLog(@"***1");
            
        }else if(self.player.currentItem.status == AVPlayerItemStatusFailed){
            
            NSLog(@"***2");
            
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
    
    
    
    }else if ([keyPath isEqualToString:@"playbackBufferEmpty"]){
    
    
        
    }else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]){
    
    
    
    
    }
  

}


#pragma mark -- MaskView delegate

- (void)ck_playButtonAction:(UIButton *)playButton{
  
    if (playButton.selected) {
        [self play];
    }else{
        [self pause];
    }
    
}

- (void)ck_backButtonAction:(UIButton *)backButton{
 
    

}


- (void)ck_fullScreenButtonAction:(UIButton *)fullScreenButton{
   
    
}


- (void)ck_sliderDragBeginAction:(CKSlider *)slider{

    
    
}

- (void)ck_sliderDragChangeAction:(CKSlider *)slider{

}

- (void)ck_sliderDragEndAction:(CKSlider *)slider{


}
#pragma mark - 播放完成
//- (void)moviePlayDidEnd:(id)sender{
//    if (_repeatPlay == NO){
//        [self pausePlay];
//    }
//    else
//    {
//        [self resetPlay];
//    }
//    if (self.EndBlock){
//        self.EndBlock();
//    }
//    
//}
#pragma mark -- 懒加载

- (UIView *)contentView{

    if (!_contentView) {
        _contentView = [[UIView alloc]init];
    }
    return _contentView;
}
-(void)setPlayerItem:(AVPlayerItem *)playerItem{
    
    if (_playerItem == playerItem){
        return;
    }
    
    if (_playerItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
        [_playerItem removeObserver:self forKeyPath:@"status"];
        [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    }
    _playerItem = playerItem;
    if (playerItem) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    }
    
}
#pragma mark - 取消定时器
//销毁所有定时器
- (void)destroyAllTimer{
    [_sliderTimer invalidate];
    [_timer invalidate];
    _sliderTimer = nil;
    _timer       = nil;
}
//销毁定时消失定时器
- (void)destroyTimer{
    [_timer invalidate];
    _timer = nil;
}
#pragma mark - dealloc
- (void)dealloc{
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:_player.currentItem];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:[UIDevice currentDevice]];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillResignActiveNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
    [self destroyAllTimer];
    NSLog(@"播放器被销毁了");
    
   
}



- (id)copyWithZone:(NSZone *)zone {
   
    return [[self class] allocWithZone:zone];

}
@end
