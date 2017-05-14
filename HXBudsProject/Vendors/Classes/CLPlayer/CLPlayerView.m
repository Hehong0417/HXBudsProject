//
//  PlayerView.m
//  CLPlayerDemo
//
//  Created by JmoVxia on 2016/11/1.
//  Copyright © 2016年 JmoVxia. All rights reserved.
//

#import "CLPlayerView.h"
#import "CLPlayerMaskView.h"
//#import "WMPlayer.h"
#import "WMLightView.h"
//消失时间
#define DisappearTime  7
/**UIScreen width*/
#define  CLscreenWidth   [UIScreen mainScreen].bounds.size.width
/**UIScreen height*/
#define  CLscreenHeight  [UIScreen mainScreen].bounds.size.height

//********添加*************//
#define Window [UIApplication sharedApplication].keyWindow
#define iOS8 [UIDevice currentDevice].systemVersion.floatValue >= 8.0

#define WMPlayerSrcName(file) [@"WMPlayer.bundle" stringByAppendingPathComponent:file]
#define WMPlayerFrameworkSrcName(file) [@"Frameworks/WMPlayer.framework/WMPlayer.bundle" stringByAppendingPathComponent:file]
//
#define WMPlayerImage(file)      [UIImage imageNamed:WMPlayerSrcName(file)] ? :[UIImage imageNamed:WMPlayerFrameworkSrcName(file)]
//

#define kHalfWidth self.frame.size.width * 0.5
#define kHalfHeight self.frame.size.height * 0.5
////整个屏幕代表的时间
#define TotalScreenTime 90
#define LeastDistance 15
//************************//

static void *PlayViewCMTimeValue = &PlayViewCMTimeValue;

static void *PlayViewStatusObservationContext = &PlayViewStatusObservationContext;





// 播放器的几种状态
typedef NS_ENUM(NSInteger, CLPlayerState) {
    CLPlayerStateFailed,     // 播放失败
    CLPlayerStateBuffering,  // 缓冲中
    CLPlayerStatePlaying,    // 播放中
    CLPlayerStateStopped,    // 停止播放
    CLPlayerStatePause       // 暂停播放
};


@interface CLPlayerView ()<CLPlayerMaskViewDelegate>
{

    //用来判断手势是否移动过
    BOOL _hasMoved;
    //记录触摸开始时的视频播放的时间
    float _touchBeginValue;
    //记录触摸开始亮度
    float _touchBeginLightValue;
    //记录触摸开始的音量
    float _touchBeginVoiceValue;
    
    //总时间
    CGFloat totalTime;

    UIView *testView;
}
//***********添加*************//

/**
 *  /给显示亮度的view添加毛玻璃效果
 */
@property (nonatomic, strong) UIVisualEffectView * effectView;

//控制亮度的View
@property (nonatomic, strong) WMLightView *lightView;

///记录touch开始的点
@property (nonatomic,assign)CGPoint touchBeginPoint;

///手势控制的类型
///判断当前手势是在控制进度?声音?亮度?
@property (nonatomic, assign) WMControlType controlType;

@property (nonatomic, strong)NSDateFormatter *dateFormatter;
//监听播放起状态的监听者


//***********************//

/**控件原始Farme*/
@property (nonatomic,assign) CGRect        customFarme;
/** 播发器的几种状态 */
@property (nonatomic,assign) CLPlayerState state;
/**父类控件*/
@property (nonatomic,strong) UIView        *fatherView;
/**视频拉伸模式*/
@property (nonatomic,copy) NSString        *videoFillMode;


/**全屏标记*/
@property (nonatomic,assign) BOOL   isFullScreen;
/**横屏标记*/
@property (nonatomic,assign) BOOL   landscape;
/**工具条隐藏标记*/
@property (nonatomic,assign) BOOL   isDisappear;


/**播放器*/
@property (nonatomic,strong) AVPlayer         *player;
/**playerLayer*/
@property (nonatomic,strong) AVPlayerLayer    *playerLayer;
/**播放器item*/
@property (nonatomic,strong) AVPlayerItem     *playerItem;
/**遮罩*/
@property (nonatomic,strong) CLPlayerMaskView *maskView;
/**轻拍定时器*/
@property (nonatomic,strong) NSTimer          *timer;
/**slider定时器*/
@property (nonatomic,strong) NSTimer          *sliderTimer;


/**返回按钮回调*/
@property (nonatomic,copy) void (^BackBlock) (UIButton *backButton);
/**播放完成回调*/
@property (nonatomic,copy) void (^EndBlock) ();

@end

@implementation CLPlayerView
#pragma mark - 懒加载
//遮罩
- (CLPlayerMaskView *) maskView{
    if (_maskView == nil){
        _maskView          = [[CLPlayerMaskView alloc] init];
        _maskView.delegate = self;
        [_maskView addTarget:self action:@selector(disappearAction:) forControlEvents:UIControlEventTouchUpInside];
        //计时器，循环执行
        _sliderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                        target:self
                                                      selector:@selector(timeStack)
                                                      userInfo:nil
                                                       repeats:YES];
        //定时器，工具条消失
        _timer = [NSTimer scheduledTimerWithTimeInterval:DisappearTime
                                                  target:self
                                                selector:@selector(disappear)
                                                userInfo:nil
                                                 repeats:NO];
            }
    return _maskView;
}
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        _isFullScreen   = NO;
        _autoFullScreen = YES;
        _repeatPlay     = YES;
        _isLandscape    = NO;
        _landscape      = NO;
        _isDisappear    = NO;
//        self.dragEnable = NO;
        self.maskView.topToolBar.hidden = YES;
        
        
        
        
//        //开启
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        //注册屏幕旋转通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
        //APP运行状态通知，将要被挂起
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
        // app进入前台
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appDidEnterPlayground:)
                                                     name:UIApplicationDidBecomeActiveNotification object:nil];
        
        [self creatUI];

    }
    return self;
}
#pragma mark - 视频拉伸方式
-(void)setFillMode:(VideoFillMode)fillMode{
    switch (fillMode){
        case ResizeAspectFill:
            //原比例拉伸视频，直到两边屏幕都占满，但视频内容有部分会被剪切
            _videoFillMode = AVLayerVideoGravityResizeAspectFill;
            break;
        case ResizeAspect:
            //按原视频比例显示，是竖屏的就显示出竖屏的，两边留黑
            _videoFillMode = AVLayerVideoGravityResizeAspect;
            break;
        case Resize:
            //拉伸视频内容达到边框占满，但不按原比例拉伸
            _videoFillMode = AVLayerVideoGravityResize;
            break;
    }
}
#pragma mark - 是否自动支持全屏
- (void)setAutoFullScreen:(BOOL)autoFullScreen{
    _autoFullScreen = autoFullScreen;
}
#pragma mark - 是否支持横屏
-(void)setIsLandscape:(BOOL)isLandscape{
    _isLandscape = isLandscape;
    _landscape   = isLandscape;
}
#pragma mark - 重复播放
- (void)setRepeatPlay:(BOOL)repeatPlay{
    _repeatPlay = repeatPlay;
}
#pragma mark - 传入播放地址
- (void)setUrl:(NSURL *)url{
    _url                      = url;
    self.playerItem           = [AVPlayerItem playerItemWithAsset:[AVAsset assetWithURL:_url]];
    //创建
    _player                   = [AVPlayer playerWithPlayerItem:_playerItem];
    _playerLayer              = [AVPlayerLayer playerLayerWithPlayer:_player];
    //全屏拉伸
    _playerLayer.videoGravity = AVLayerVideoGravityResize;
  //*******添加**********//
    self.player.usesExternalPlaybackWhileExternalScreenIsActive=YES;

    self.playerLayer.frame = self.contentView.layer.bounds;
    
  //********************//
    //设置静音模式播放声音
    AVAudioSession * session  = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    if (_videoFillMode){
        _playerLayer.videoGravity = _videoFillMode;
    }
    //放到最下面，防止遮挡
    [self.contentView.layer insertSublayer:_playerLayer atIndex:0];
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
- (void)setState:(CLPlayerState)state{
    _state = state;
    if (state == CLPlayerStateBuffering) {
        [self.maskView.activity startAnimating];
    }else if (state == CLPlayerStateFailed){
        [self.maskView.activity stopAnimating];
        NSLog(@"加载失败");
        self.maskView.failButton.hidden = NO;
    }else{
        [self.maskView.activity stopAnimating];
        [self playVideo];
    }
}
#pragma mark - 创建播放器UI
- (void)creatUI{
    self.backgroundColor = [UIColor blackColor];

    //**********添加***********//
    
    WEAK_SELF();
    self.BackBlock = ^(UIButton *backButton){
        
        [weakSelf originalscreen];
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
        weakSelf.lightView.transform =  CGAffineTransformMakeRotation( - M_PI / 2);
        [weakSelf.vc setNeedsStatusBarAppearanceUpdate];
        [weakSelf.vc.navigationController setNavigationBarHidden:NO];
    };

    
    //wmplayer内部的一个view，用来管理子视图
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.contentView];
    
    
    //最上面的View
    [self.contentView addSubview:self.maskView];

    //创建fastForwardView
    [self creatFF_View];
    
    self.lightView = [[WMLightView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    [kKeyWindow addSubview:self.lightView];
 
    [self.lightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(kKeyWindow);
        make.width.equalTo(@(155));
        make.height.equalTo(@155);
    }];
    

    NSLog(@"sharedLightView*****%@******",NSStringFromCGRect(self.lightView.frame));
    
    
    self.enableVolumeGesture = YES;
    self.enableFastForwardGesture = YES;
    
    self.volumeView = [[MPVolumeView alloc]init];
    for (UIControl *view in self.volumeView.subviews) {
        if ([view.superclass isSubclassOfClass:[UISlider class]]) {
            self.volumeSlider = (UISlider *)view;
        }
    }
   
    
    UIPanGestureRecognizer *panTap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(actionPanTapGesture:)];
//    panTap.delegate = self;
    [self.contentView addGestureRecognizer:panTap];
    
    
    if(self.isFullScreen){
    
        self.maskView.topToolBarHeight = WidthScaleSize_H(50);
        self.maskView.bottomToolBarHeight = WidthScaleSize_H(45);
        
    }else{
    
        self.maskView.bottomToolBarHeight = WidthScaleSize_H(35);
    }
    
    //**********************//
}


#pragma mark - 隐藏或者显示状态栏方法
- (void)setStatusBarHidden:(BOOL)hidden{
    //取出当前控制器的导航条
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    //设置是否隐藏
    statusBar.hidden  = hidden;
}


#pragma mark - 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        
        if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
            self.state = CLPlayerStatePlaying;
        }
        else if (self.player.currentItem.status == AVPlayerItemStatusFailed) {
            self.state = CLPlayerStateFailed;
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
        // 计算缓冲进度
        NSTimeInterval timeInterval = [self availableDuration];
        CMTime duration             = self.playerItem.duration;
        CGFloat totalDuration       = CMTimeGetSeconds(duration);
        [self.maskView.progress setProgress:timeInterval / totalDuration animated:NO];

    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
        
        // 当缓冲是空的时候
        if (self.playerItem.playbackBufferEmpty) {
            self.state = CLPlayerStateBuffering;
            [self bufferingSomeSecond];
        }
        
    } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        
        // 当缓冲好的时候
        if (self.playerItem.playbackLikelyToKeepUp && self.state == CLPlayerStateBuffering){
            self.state = CLPlayerStatePlaying;
        }
        
    }
}

#pragma mark - 缓冲较差时候
//卡顿时会走这里
- (void)bufferingSomeSecond{
    self.state = CLPlayerStateBuffering;

    __block BOOL isBuffering = NO;
    if (isBuffering) return;
    isBuffering = YES;
    
    // 需要先暂停一小会之后再播放，否则网络状况不好的时候时间在走，声音播放不出来
    [self pausePlay];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self playVideo];
        // 如果执行了play还是没有播放则说明还没有缓存好，则再次缓存一段时间
        isBuffering = NO;
        if (!self.playerItem.isPlaybackLikelyToKeepUp) {
            [self bufferingSomeSecond];
        }
        
    });
}
//计算缓冲进度
- (NSTimeInterval)availableDuration{
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange     = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds        = CMTimeGetSeconds(timeRange.start);
    float durationSeconds     = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result     = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}
#pragma mark - 拖动进度条
//开始
-(void)cl_progressSliderTouchBegan:(CLSlider *)slider{
    //暂停
    [self pausePlay];
    [self destroyTimer];
}
//结束
-(void)cl_progressSliderTouchEnded:(CLSlider *)slider{
    //继续播放
    [self playVideo];
    _timer = [NSTimer scheduledTimerWithTimeInterval:DisappearTime
                                              target:self
                                            selector:@selector(disappear)
                                            userInfo:nil
                                             repeats:NO];
}
//CGPoint touchLocation = [sender locationInView:self.progressSlider];
//CGFloat value = (self.progressSlider.maximumValue - self.progressSlider.minimumValue) * (touchLocation.x/self.progressSlider.frame.size.width);
//[self.progressSlider setValue:value animated:YES];

//拖拽中
-(void)cl_progressSliderValueChanged:(CLSlider *)slider{
    //计算出拖动的当前秒数
    CGFloat total           = (CGFloat)_playerItem.duration.value / _playerItem.duration.timescale;
    NSInteger dragedSeconds = floorf(total * slider.value);
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime     = CMTimeMake(dragedSeconds, 1);
    [_player seekToTime:dragedCMTime];
}
//***********添加*************//
-(void)creatFF_View{
    self.FF_View = [[NSBundle mainBundle] loadNibNamed:@"FastForwardView" owner:self options:nil].lastObject;
    self.FF_View.hidden = YES;
    self.FF_View.layer.cornerRadius = 10.0;
    [self.contentView addSubview:self.FF_View];
    
    [self.FF_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.maskView);
        make.width.equalTo(@(120));
        make.height.equalTo(@60);
    }];

}

#pragma mark - 滑动屏幕

- (void)actionPanTapGesture:(UIPanGestureRecognizer *)sender{
    
    CGPoint locationPoint = [sender locationInView:self];

    if (sender.state == UIGestureRecognizerStateBegan) {
        
        CGPoint startPoint = [sender locationInView:self];
        //触摸开始, 初始化一些值
        _hasMoved = NO;
        _touchBeginValue = (NSInteger)CMTimeGetSeconds([_player currentTime]);

        //位置
        _touchBeginPoint = startPoint;
        
        //亮度
        _touchBeginLightValue = [UIScreen mainScreen].brightness;
        //声音
        _touchBeginVoiceValue = _volumeSlider.value;
        //
        
        
    }else if(sender.state == UIGestureRecognizerStateChanged){
        
        //如果移动的距离过于小, 就判断为没有移动
        CGPoint tempPoint = locationPoint;
        
        if (fabs(tempPoint.x - _touchBeginPoint.x) < LeastDistance && fabs(tempPoint.y - _touchBeginPoint.y) < LeastDistance) {
            return;
        }
        _hasMoved = YES;
        //如果还没有判断出使什么控制手势, 就进行判断
        //滑动角度的tan值
        float tan = fabs(tempPoint.y - _touchBeginPoint.y)/fabs(tempPoint.x - _touchBeginPoint.x);
        
        if (tan < 1/sqrt(3)) {
            //当滑动角度小于30度的时候, 进度手势
            
            _controlType = progressControl;
            //            _controlJudge = YES;
        }else if(tan > sqrt(3)){  //当滑动角度大于60度的时候, 声音和亮度
            //判断是在屏幕的左半边还是右半边滑动, 左侧控制为亮度, 右侧控制音量
            if (_touchBeginPoint.x < self.bounds.size.width/2) {
                _controlType = lightControl;
            }else{
                _controlType = voiceControl;
            }
            //            _controlJudge = YES;
        }else{     //如果是其他角度则不是任何控制
            _controlType = noneControl;
            return;
        }
        
        
        if (_controlType == progressControl) {     //如果是进度手势
            if (self.enableFastForwardGesture) {
                
                float value = [self moveProgressControllWithTempPoint:tempPoint];
                [self timeValueChangingWithValue:value];
                
            }
        }else if(_controlType == voiceControl){    //如果是音量手势
//            if (_isFullScreen) {//全屏的时候才开启音量的手势调节
            
                if (self.enableVolumeGesture) {
                    //根据触摸开始时的音量和触摸开始时的点去计算出现在滑动到的音量
                    float voiceValue = _touchBeginVoiceValue - ((tempPoint.y - _touchBeginPoint.y)/self.bounds.size.height);
                    //判断控制一下, 不能超出 0~1
                    if (voiceValue < 0) {
                        _volumeSlider.value = 0;
                    }else if(voiceValue > 1){
                        _volumeSlider.value = 1;
                    }else{
                        _volumeSlider.value = voiceValue;
                    }
                }
//            }else{
//                return;
//            }
        }else if(_controlType == lightControl){   //如果是亮度手势
            
            NSLog(@"lightControl*****%.2f******",self.lightView.frame.size.width);

            [self hideTheLightViewWithHidden:NO];
//            if (_isFullScreen) {
                //根据触摸开始时的亮度, 和触摸开始时的点来计算出现在的亮度
                float tempLightValue = _touchBeginLightValue - ((tempPoint.y - _touchBeginPoint.y)/self.bounds.size.height);
                if (tempLightValue < 0) {
                    tempLightValue = 0;
                }else if(tempLightValue > 1){
                    tempLightValue = 1;
                }
                //        控制亮度的方法
                [UIScreen mainScreen].brightness = tempLightValue;
                //        实时改变现实亮度进度的view
                NSLog(@"亮度调节 = %f",tempLightValue);
//            }else{
//                
//            }
        }
        
    }else if(sender.state == UIGestureRecognizerStateEnded){
        
        NSLog(@"touchesEnded");
        self.FF_View.hidden = YES;
        [self hideTheLightViewWithHidden:YES];
        //判断是否移动过,
        if (_hasMoved) {
            if (_controlType == progressControl) { //进度控制就跳到响应的进度
                //            if ([self.delegate respondsToSelector:@selector(seekToTheTimeValue:)]) {
                if (self.enableFastForwardGesture) {
                    CGPoint tempPoint = locationPoint;
                    float value = [self moveProgressControllWithTempPoint:tempPoint];
                    //                [self.delegate seekToTheTimeValue:value];
                    [self seekToTimeToPlay:value];
                    //            }
                    self.FF_View.hidden = YES;
                }
                
            }else if (_controlType == lightControl){//如果是亮度控制, 控制完亮度还要隐藏显示亮度的view
                [self hideTheLightViewWithHidden:YES];
            }
        }else{
            //        if (self.topView.hidden) {
            //            [self controlViewOutHidden];
            //        }else{
            //            [self controlViewHidden];
            //        }
        }
        
        
        
        
        
    }else if(sender.state == UIGestureRecognizerStateCancelled){
        
        //判断是否移动过,
        if (_hasMoved) {
            if (_controlType == progressControl) { //进度控制就跳到响应的进度
                CGPoint tempPoint = locationPoint;
                //            if ([self.delegate respondsToSelector:@selector(seekToTheTimeValue:)]) {
                if (self.enableFastForwardGesture) {
                    float value = [self moveProgressControllWithTempPoint:tempPoint];
                    //                [self.delegate seekToTheTimeValue:value];
                    [self seekToTimeToPlay:value];
                }
                //            }
                self.FF_View.hidden = YES;
            }else if (_controlType == lightControl){//如果是亮度控制, 控制完亮度还要隐藏显示亮度的view
                [self hideTheLightViewWithHidden:YES];
            }
        }else{
            
        }
        
    }
    
}
- (void)seekToTimeToPlay:(double)time{
    if (self.player&&self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
       //
        totalTime = (CGFloat)CMTimeGetSeconds(_playerItem.duration);

        if (time>=totalTime) {
            time = 0.0;
        }
        if (time<0) {
            time=0.0;
        }
        //        int32_t timeScale = self.player.currentItem.asset.duration.timescale;
        //currentItem.asset.duration.timescale计算的时候严重堵塞主线程，慎用
        /* A timescale of 1 means you can only specify whole seconds to seek to. The timescale is the number of parts per second. Use 600 for video, as Apple recommends, since it is a product of the common video frame rates like 50, 60, 25 and 24 frames per second*/
        
        [self.player seekToTime:CMTimeMakeWithSeconds(time, self.playerItem.currentTime.timescale) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
            
        }];
        
    }
}

//#pragma mark - 用来控制移动过程中计算手指划过的时间
-(float)moveProgressControllWithTempPoint:(CGPoint)tempPoint{
    //90代表整个屏幕代表的时间
    
    float value = TotalScreenTime * ((tempPoint.x - _touchBeginPoint.x)/([UIScreen mainScreen].bounds.size.width));
    
    float tempValue = _touchBeginValue +value;
    if (tempValue > [self duration]) {
        tempValue = [self duration];
    }else if (tempValue < 0){
        
        tempValue = 0.0f;
    }


    return tempValue;
}
///获取视频长度
- (double)duration{
    AVPlayerItem *playerItem = self.player.currentItem;
    if (playerItem.status == AVPlayerItemStatusReadyToPlay){
        return CMTimeGetSeconds([[playerItem asset] duration]);
    }
    else{
        return 0.f;
    }
}
- (NSString *)convertTime:(float)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    return [[self dateFormatter] stringFromDate:d];
}
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    }
    return _dateFormatter;
}
#pragma mark - 用来显示时间的view在时间发生变化时所作的操作
-(void)timeValueChangingWithValue:(float)value{
    if (value > _touchBeginValue) {
        self.FF_View.sheetStateImageView.image = WMPlayerImage(@"progress_icon_r");
    }else if(value < _touchBeginValue){
        self.FF_View.sheetStateImageView.image =WMPlayerImage(@"progress_icon_l");
    }
    
    self.FF_View.hidden = NO;
    self.FF_View.sheetTimeLabel.text = [NSString stringWithFormat:@"%@/%@", [self convertTime:value], [self convertTime:totalTime]];
    self.maskView.currentTimeLabel.text = [self convertTime:value];
    CGFloat sliderValue = value/totalTime;
    [self.maskView.slider setValue:sliderValue animated:YES];
}

NSString * calculateTimeWithTimeFormatter(long long timeSecond){
    NSString * theLastTime = nil;
    if (timeSecond < 60) {
        theLastTime = [NSString stringWithFormat:@"00:%.2lld", timeSecond];
    }else if(timeSecond >= 60 && timeSecond < 3600){
        theLastTime = [NSString stringWithFormat:@"%.2lld:%.2lld", timeSecond/60, timeSecond%60];
    }else if(timeSecond >= 3600){
        theLastTime = [NSString stringWithFormat:@"%.2lld:%.2lld:%.2lld", timeSecond/3600, timeSecond%3600/60, timeSecond%60];
    }
    return theLastTime;
}


#pragma mark -
#pragma mark - 用来控制显示亮度的view, 以及毛玻璃效果的view
-(void)hideTheLightViewWithHidden:(BOOL)hidden{
    if (self.isFullScreen) {//全屏才出亮度调节的view
        if (hidden) {
            [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                if (iOS8) {
                    self.effectView.alpha = 0.0;
                }
            } completion:nil];
            
        }else{
            if (iOS8) {
                self.effectView.alpha = 1.0;
            }
        }
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            self.effectView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.height)/2-155/2, ([UIScreen mainScreen].bounds.size.width)/2-155/2, 155, 155);
        }
    }else{
        return;
    }
    
}


//************************//

#pragma mark - 计时器事件
- (void)timeStack{
    if (_playerItem.duration.timescale != 0){
        //总共时长
        self.maskView.slider.maximumValue = 1;
        //当前进度
        self.maskView.slider.value        = CMTimeGetSeconds([_playerItem currentTime]) / (_playerItem.duration.value / _playerItem.duration.timescale);

        //当前时长进度progress
        NSInteger proMin     = (NSInteger)CMTimeGetSeconds([_player currentTime]) / 60;//当前秒
        NSInteger proSec     = (NSInteger)CMTimeGetSeconds([_player currentTime]) % 60;//当前分钟
        self.maskView.currentTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", proMin, proSec];
        
        //duration 总时长
        NSInteger durMin     = (NSInteger)_playerItem.duration.value / _playerItem.duration.timescale / 60;//总分钟
        NSInteger durSec     = (NSInteger)_playerItem.duration.value / _playerItem.duration.timescale % 60;//总秒
        self.maskView.totalTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", durMin, durSec];
    }
}
#pragma mark - 播放暂停按钮方法
-(void)cl_playButtonAction:(UIButton *)button{
    if (button.selected == NO){
        [self pausePlay];
    }
    else{
        [self playVideo];
    }
}
#pragma mark - 全屏按钮响应事件
-(void)cl_fullButtonAction:(UIButton *)button{
    _isLandscape = NO;
    if (_isFullScreen == NO){
        [self fullScreenWithDirection:UIInterfaceOrientationLandscapeRight];
    }
    else{
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
        
        [self.vc setNeedsStatusBarAppearanceUpdate];
        [self.vc.navigationController setNavigationBarHidden:NO];
        [self originalscreen];

    }
    _isLandscape = _landscape;
}
#pragma mark - 播放失败按钮点击事件
-(void)cl_failButtonAction:(UIButton *)button{
    [self setUrl:_url];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
#pragma mark - 点击响应
- (void)disappearAction:(UIButton *)button{
    
    //取消定时消失
    [self destroyTimer];
    if (_isDisappear == NO){
        //*******消失******
        [UIView animateWithDuration:3 animations:^{

        if (!self.isFullScreen) {
            
            [self setStatusBarHidden:NO];

        }else{
            
         [self setStatusBarHidden:YES];
            
             }
        }];
        [UIView animateWithDuration:0.25 animations:^{
            self.maskView.topToolBar.alpha    = 0;
            self.maskView.bottomToolBar.alpha = 0;

        }];
    }
    else{
        //********出现********
        [UIView animateWithDuration:3 animations:^{
          [self setStatusBarHidden:NO];
        }];
        
//        //添加定时消失
        _timer = [NSTimer scheduledTimerWithTimeInterval:DisappearTime
                                                  target:self
                                                selector:@selector(disappear)
                                                userInfo:nil
                                                 repeats:NO];
        
        [UIView animateWithDuration:0.1 animations:^{
            self.maskView.topToolBar.alpha    = 1.0;
            self.maskView.bottomToolBar.alpha = 1.0;

        }];
    }
    _isDisappear = !_isDisappear;
}
#pragma mark - 定时消失
- (void)disappear{
    [UIView animateWithDuration:0.5 animations:^{
        self.maskView.topToolBar.alpha    = 0;
        self.maskView.bottomToolBar.alpha = 0;
        
        if (!self.isFullScreen) {
            
            [self setStatusBarHidden:NO];
            
        }else{
            
            [self setStatusBarHidden:YES];
            
        }
    }];
}
#pragma mark - 播放完成
- (void)moviePlayDidEnd:(id)sender{
    if (_repeatPlay == NO){
        [self pausePlay];
    }
    else
    {
        [self resetPlay];
    }
    if (self.EndBlock){
        self.EndBlock();
    }
    
}
- (void)endPlay:(EndBolck) end{
    self.EndBlock = end;
}
#pragma mark - 返回按钮
-(void)cl_backButtonAction:(UIButton *)button{
    if (self.BackBlock){
        self.BackBlock(button);
    }
}
- (void)backButton:(BackButtonBlock) backButton;{
    self.BackBlock = backButton;
}
#pragma mark - 暂停播放
- (void)pausePlay{
    self.maskView.playButton.selected = NO;
    [_player pause];
}
#pragma mark - 播放
- (void)playVideo{
    self.maskView.playButton.selected = YES;
    [_player play];
}
#pragma mark - 重新开始播放
- (void)resetPlay{
    [_player seekToTime:CMTimeMake(0, 1)];
    [self playVideo];
}
#pragma mark - 销毁播放器
- (void)destroyPlayer{
    //销毁定时器
    [self destroyAllTimer];
    //暂停
    [_player pause];
    //清除
    [_player.currentItem cancelPendingSeeks];
    [_player.currentItem.asset cancelLoading];
    //移除
    [self removeFromSuperview];

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
#pragma mark - 屏幕旋转通知

- (void)orientChange:(NSNotification *)notification{
    if (_autoFullScreen == NO){
        return;
    }
    
    [self getCurrentDeviceOrientation];
}

- (CGAffineTransform)getCurrentDeviceOrientation{

    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation currentOrientation = (UIInterfaceOrientation)orientation;

    if (orientation == UIDeviceOrientationLandscapeLeft){
        if (_isFullScreen == NO){
        self.transform = [self fullScreenWithDirection:currentOrientation];

        }
    }
    else if (orientation == UIDeviceOrientationLandscapeRight){
        if (_isFullScreen == NO){
         self.transform =  [self fullScreenWithDirection:currentOrientation];
        }
    }
    else if (orientation == UIDeviceOrientationPortrait){
        if (_isFullScreen == YES){
            
        self.transform = [self originalscreen];
        self.lightView.transform =  [self originalscreen];;

         [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
         [self.vc setNeedsStatusBarAppearanceUpdate];
         [self.vc.navigationController setNavigationBarHidden:NO];
        }
    }

    
    return self.transform;
}

#pragma mark - 全屏

- (CGAffineTransform)fullScreenWithDirection:(UIInterfaceOrientation)direction{
    
    //隐藏顶部工具条
    self.maskView.topToolBar.hidden = NO;
    
    //记录播放器父类
    _fatherView = self.superview;
    //记录原始大小
    _customFarme = self.frame;
    _isFullScreen = YES;
    [self.vc.navigationController setNavigationBarHidden:YES];
    [self setStatusBarHidden:NO];

    //添加到Window上
//    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self.vc.view addSubview:self];
    
    
    //*******************//
//    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    NSLog(@"currentOrientation:::::%ld",direction);

    if (_isLandscape == YES){
        self.frame = CGRectMake(0, 0, CLscreenWidth,CLscreenHeight);
        
    }
    else{

        if (direction == UIInterfaceOrientationLandscapeRight){
            [UIView animateWithDuration:0.25 animations:^{
                self.transform = CGAffineTransformMakeRotation(M_PI / 2);
                self.lightView.transform =  CGAffineTransformMakeRotation(M_PI / 2);
            }];
        }
        else{
            [UIView animateWithDuration:0.25 animations:^{
                self.transform = CGAffineTransformMakeRotation( - M_PI / 2);
                self.lightView.transform =  CGAffineTransformMakeRotation( - M_PI / 2);

            }];
        }
    }
    self.frame = CGRectMake(0, 0,CLscreenWidth,CLscreenHeight);
    
    self.maskView.fullButton.selected = YES;

    [[UIApplication sharedApplication] setStatusBarOrientation:direction animated:NO];
    
    [self.vc setNeedsStatusBarAppearanceUpdate];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    return self.transform;
}

#pragma mark - 原始大小
- (CGAffineTransform)originalscreen{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
    
    _isFullScreen = NO;
    self.maskView.topToolBar.hidden = YES;
    [self setStatusBarHidden:NO];
    [UIView animateWithDuration:0.25 animations:^{
        //还原
        self.transform = CGAffineTransformMakeRotation(0);
    }];
    self.frame = _customFarme;
    //还原到原有父类上
    [_fatherView addSubview:self];
    self.maskView.fullButton.selected = NO;
    
    return self.transform;
}
#pragma mark - APP活动通知
- (void)appDidEnterBackground:(NSNotification *)note{
    //将要挂起，停止播放
    [self pausePlay];
}
- (void)appDidEnterPlayground:(NSNotification *)note{
    //继续播放
    [self playVideo];
}
#pragma mark - 获取资源图片
- (UIImage *)getPictureWithName:(NSString *)name{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"CLPlayer" ofType:@"bundle"]];
    NSString *path   = [bundle pathForResource:name ofType:@"png"];
    return [UIImage imageWithContentsOfFile:path];
}
#pragma mark - 根据Cell位置判断是否销毁
- (void)calculateWith:(UITableView *)tableView cell:(UITableViewCell *)cell topOffset:(CGFloat)topOffset bottomOffset:(CGFloat)bottomOffset beyond:(BeyondBlock) beyond;{
    //取出cell位置
    CGRect rect        = cell.frame;
    //cell顶部
    CGFloat cellTop    = rect.origin.y;
    //cell底部
    CGFloat cellBottom = rect.origin.y + rect.size.height;
    
    
    if (tableView.contentOffset.y + topOffset > cellBottom){
        if (beyond){
            beyond();
        }
        return;
    }
    
    if (cellTop > tableView.contentOffset.y + tableView.frame.size.height - bottomOffset){
        if (beyond){
            beyond();
        }
        return;
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.playerLayer.frame        = self.bounds;
    self.maskView.frame = self.bounds;
    self.contentView.frame = self.bounds;
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
    
    //**********添加**********//
    
    for (UIView *aLightView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([aLightView isKindOfClass:[WMLightView class]]) {
            [aLightView removeFromSuperview];
        }
    }
    [self.effectView removeFromSuperview];
    self.effectView = nil;
    [self.playerLayer removeFromSuperlayer];
    self.playerLayer = nil;
    [self.player replaceCurrentItemWithPlayerItem:nil];

    
    //************************//
}



@end
