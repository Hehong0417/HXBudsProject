//
//  PlayerView.h
//  CLPlayerDemo
//
//  Created by JmoVxia on 2016/11/1.
//  Copyright © 2016年 JmoVxia. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FastForwardView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "WMDragView.h"


//手势操作的类型
typedef NS_ENUM(NSUInteger,WMControlType) {
    progressControl,//视频进度调节操作
    voiceControl,//声音调节操作
    lightControl,//屏幕亮度调节操作
    noneControl//无任何操作
} ;

typedef NS_ENUM(NSInteger,VideoFillMode){
    Resize = 0,          //拉伸占满整个播放器，不按原比例拉伸
    ResizeAspect,        //按原视频比例显示，是竖屏的就显示出竖屏的，两边留黑
    ResizeAspectFill,    //按照原比例拉伸占满整个播放器，但视频内容超出部分会被剪切
};

typedef void(^BackButtonBlock)(UIButton *button);
typedef void(^EndBolck)();
typedef void(^BeyondBlock)();

@interface CLPlayerView : WMDragView

//*******添加********//

///声音滑块
@property (nonatomic,strong) UISlider       *volumeSlider;
//这个用来显示滑动屏幕时的时间
@property (nonatomic,strong) FastForwardView * FF_View;

@property (nonatomic,strong) MPVolumeView *volumeView;


/**
 *  是否使用手势控制音量
 */
@property (nonatomic,assign) BOOL  enableVolumeGesture;
/**
 *  是否使用手势控制进度
 */
@property (nonatomic,assign) BOOL  enableFastForwardGesture;


@property (nonatomic,strong) UIView        *contentView;

-(CGAffineTransform)getCurrentDeviceOrientation;

//******************//


/**视频url*/
@property (nonatomic,strong) NSURL *url;
/**旋转自动全屏，默认Yes*/
@property (nonatomic,assign) BOOL autoFullScreen;
/**重复播放，默认No*/
@property (nonatomic,assign) BOOL repeatPlay;
/**是否支持横屏，默认No*/
@property (nonatomic,assign) BOOL isLandscape;
/**拉伸方式，默认全屏填充*/
@property (nonatomic,assign) VideoFillMode fillMode;



/**播放*/
- (void)playVideo;
/**暂停*/
- (void)pausePlay;
/**返回按钮回调方法*/
- (void)backButton:(BackButtonBlock) backButton;
/**播放完成回调*/
- (void)endPlay:(EndBolck) end;
/**销毁播放器*/
- (void)destroyPlayer;

/**
 根据播放器所在位置计算是否滑出tableView，根据上下偏移量可以精准的计算你想要销毁播放器的位置
 
 @param tableView tableView
 @param cell 播放器所在cell
 @param topOffset tableview 相对于屏幕顶部的偏移（根据你自己需求设置）
 @param bottomOffset  tableView 相对于屏幕底部的偏移
 @param beyond 超出后的回调
 */
- (void)calculateWith:(UITableView *)tableView cell:(UITableViewCell *)cell topOffset:(CGFloat)topOffset bottomOffset:(CGFloat)bottomOffset beyond:(BeyondBlock) beyond;





@end
