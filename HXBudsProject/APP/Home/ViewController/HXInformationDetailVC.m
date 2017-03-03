
//
//  HXInformationDetailVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXInformationDetailVC.h"

@interface HXInformationDetailVC ()

@end

@implementation HXInformationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"艺考资讯";
  
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64)];

    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
}


@end
