//
//  ViewController.m
//  CKPlayerDemo
//
//  Created by n on 2017/3/16.
//  Copyright © 2017年 n. All rights reserved.
//

#import "ViewController.h"
#import "CKPlayerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    UIView *playView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220)];
    playView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:playView];
    
    CKPlayerView *ckView = [[CKPlayerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220)];
    ckView.url = [NSURL URLWithString:@"http://yycloudvod2109130935.bs2dl.yy.com/djhmZjcyZTExZDRiZmY1Yzg0NzhlM2Q5MWVjZjRhYzY1MTUzNDQxMjM1Mg"];
    [self.view addSubview:ckView];
    
    
}




@end
