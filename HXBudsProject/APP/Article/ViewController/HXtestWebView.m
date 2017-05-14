//
//  HXtestWebView.m
//  HXBudsProject
//
//  Created by n on 2017/5/12.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXtestWebView.h"

@interface HXtestWebView ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation HXtestWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    self.webView.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:article_detail_url]];
    
    [self.webView loadRequest:request];
    
    
    [self.view addSubview:self.webView];
    
    
}
#pragma mark-------UIWebViewDelegate代理方法-----------
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
    if ([[NSString stringWithFormat:@"%@",request.URL] isEqualToString:@"app://share"]) {
        return NO;
    }
    return YES;
}


@end
