//
//  HXPlayerVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXPlayerVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface HXPlayerVC ()<AVPlayerViewControllerDelegate>
@property (nonatomic,strong) AVPlayerViewController *playerViewController;
@end

@implementation HXPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  UIButton  *consultBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 100, 100, 35)  target:self action:@selector(consultAction) title:@"播放" titleColor: kWhiteColor font:FONT(18) backgroundColor:APP_COMMON_COLOR];
    
    [self.view addSubview:consultBtn];
    
    
}
- (void)consultAction {

    _playerViewController = [[AVPlayerViewController alloc]init];
    _playerViewController.player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://yycloudvod2109130935.bs2dl.yy.com/djhmZjcyZTExZDRiZmY1Yzg0NzhlM2Q5MWVjZjRhYzY1MTUzNDQxMjM1Mg"]];
    // 设置拉伸模式
    _playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
    // 设置是否显示媒体播放组件
    _playerViewController.showsPlaybackControls = YES;
    // 设置大力
    _playerViewController.delegate = self;
    // 播放视频
    [_playerViewController.player play];
    // 设置媒体播放器视图大小
    _playerViewController.view.bounds = CGRectMake(0, 0, 350, 300);
    _playerViewController.view.center = CGPointMake(CGRectGetMidX(self.view.bounds), 64 + CGRectGetMidY(_playerViewController.view.bounds) + 30);
    // 4、推送播放
    // 推送至媒体播放器进行播放
    // [self presentViewController:_playerViewController animated:YES completion:nil];
    // 直接在本视图控制器播放
    [self addChildViewController:_playerViewController];
    [self.view addSubview:_playerViewController.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
