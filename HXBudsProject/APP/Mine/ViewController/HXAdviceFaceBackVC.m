//
//  HXAdviceFaceBackVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXAdviceFaceBackVC.h"

@interface HXAdviceFaceBackVC ()

@end

@implementation HXAdviceFaceBackVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"意见反馈";

    UITextView  *adviceTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH - 40, 300)];
    adviceTextView.font= FONT(14);
    
    
    UIButton *btn = [UIButton lh_buttonWithFrame:CGRectMake(0, CGRectGetMaxY(adviceTextView.frame)+10, SCREEN_WIDTH ,30 ) target:self action:@selector(adviceFacebackAction) title:@"提交反馈" titleColor:kGrayColor font:FONT(14) backgroundColor:kWhiteColor];
    
    [self.view addSubview:btn];
    
    [self.view addSubview:adviceTextView];
}

- (void)adviceFacebackAction {


}



@end
