//
//  HXArticleDetailVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXArticleDetailVC.h"
#import <WebKit/WebKit.h>
#import "LWActiveIncator.h"
#import "publishedArticleViewModel.h"

@interface HXArticleDetailVC ()<WKUIDelegate,WKNavigationDelegate>

@end

@implementation HXArticleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kWhiteColor;
    
    //文章详情
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    WKWebView *wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:config];
    wkWebView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
//    [wkWebView evaluateJavaScript:@"" completionHandler:^(id _Nullable, NSError * _Nullable error) {
//        
//    }];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:article_detail_url]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jianshu.com/p/f79589c21dc4"]];

    
//    NSString *htmlStr = self.articleModel.article_content;
//    
//    [wkWebView loadHTMLString:htmlStr baseURL:nil];

   [wkWebView loadRequest:request];
    wkWebView.navigationDelegate = self;
    wkWebView.UIDelegate = self;
    [self.view addSubview:wkWebView];
    

}
//// 页面开始加载时调用
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    
//    [LWActiveIncator showInView:self.view];
//
//}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{


}
// 页面加载完成之后调用
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//
//    [LWActiveIncator hideInViwe:self.view];
//
//}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{



}

@end
