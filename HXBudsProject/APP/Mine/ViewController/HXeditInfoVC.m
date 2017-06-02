//
//  HXeditInfoVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/15.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXeditInfoVC.h"

@interface HXeditInfoVC ()
@property(nonatomic,strong) UITextView *textView;

@end

@implementation HXeditInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.titleStr;
    self.textView = [[UITextView alloc] init];
    self.textView.font = FONT(14);
    self.view.backgroundColor = KVCBackGroundColor;
    if (self.personIntroduce) {
        self.textView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 80);
    }else{
        self.textView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 45);
    }
    [self.view addSubview:self.textView];
    
    
    UIButton *saveBtn = [UIButton lh_buttonWithFrame:CGRectMake(50, 0, 60, 80) target:self action:@selector(finishAction:) title:@"完成" titleColor:APP_COMMON_COLOR font:FONT(16) backgroundColor:kClearColor];
    UIBarButtonItem *rightBarItem =  [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)finishAction:(UIButton *)btn{

    self.itemBlock(self.textView.text);
    [self.navigationController popVC];

}

@end
