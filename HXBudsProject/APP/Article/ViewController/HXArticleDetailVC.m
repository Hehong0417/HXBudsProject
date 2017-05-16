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
#import "HXInformationCommentView.h"
#import "HXarticleReviewAPI.h"
#import "HXappreciationAPI.h"
#import "HXArewardVC.h"
#import "HXIsLoginAPI.h"
#import "HXInputView.h"


@interface HXArticleDetailVC ()<WKUIDelegate,WKNavigationDelegate,InputViewDelegate>

//@property WKWebViewJavascriptBridge* bridge;

@property (nonatomic, strong) HXInputView *inputView;

//键盘高度
@property (nonatomic, assign) CGFloat keyboardHeight;

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) HJLoginModel *loginModel;


@end

@implementation HXArticleDetailVC
- (void) viewWillAppear: (BOOL)animated {
    
    //关闭键盘事件相应

    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;

}

- (void) viewWillDisappear: (BOOL)animated {
    
    //打开键盘事件相应
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kWhiteColor;
    
    //文章详情
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
     self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114) configuration:config];
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:article_detail_url]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jianshu.com/p/f79589c21dc4"]];

//   [wkWebView loadRequest:request];
//
//    [self.view addSubview:wkWebView];

    //
//    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114)];
//    self.webView.delegate = self;
//    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;

//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:article_detail_url]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jianshu.com/p/f79589c21dc4"]];
    [self.webView loadRequest:request];
    self.webView.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:self.webView];

    
    //
    HXInformationCommentView *commentView = [[HXInformationCommentView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49-64, SCREEN_WIDTH, 79)];
    [commentView.collectionBtn setTapActionWithBlock:^{
        
        
    }];
    [commentView lh_setCornerRadius:0 borderWidth:1 borderColor:KVCBackGroundColor];
    [self.view addSubview:commentView];
    
    //键盘弹出后的评论框
    self.inputView = [[HXInputView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 140)];
    self.inputView.backgroundColor = KVCBackGroundColor;
    self.inputView.delegate = self;
    [self.view addSubview:self.inputView];
    
    [self.inputView.sendBtn addTarget:self action:@selector(sendCommentAction) forControlEvents:UIControlEventTouchUpInside];
    
    //********//
//    
//    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:wkWebView];
//
//    [self.bridge setWebViewDelegate:self];
//    
    UIButton *btn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 60, 60) target:self action:@selector(ActionClisk) image:nil title:@"评论" titleColor:kBlackColor font:FONT(14)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//
//    [self.bridge registerHandler:@"exceptionalAction" handler:^(id data, WVJBResponseCallback responseCallback) {
//        
//        NSLog(@"exceptionalAction called: %@", data);
//        
//        responseCallback(@"Response from exceptionalAction");
//        
//    }];
    self.loginModel = [HJUser sharedUser].pd;
    [[[HXIsLoginAPI isLoginWithToken:self.loginModel.token] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        NSString *isLoginStr = responseObject[@"pd"][@"islogin"];
        if ([isLoginStr isEqualToString:@"no"]) {
            self.isLogin = NO;
        }else {
            self.isLogin = YES;
        }
        if (error) {
            self.isLogin = NO;
        }
    }];
    
}
//点击屏幕，键盘消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [ self.inputView.inputView resignFirstResponder];
}
- (void)ActionClisk {
//
//    [self.bridge callHandler:@"exceptionalAction" data:@{@"article_id":self.articleModel.article_id} responseCallback:^(id responseData) {
//        
//        
//    }];
    HXArewardVC *vc = [HXArewardVC new];
    vc.article_id = self.articleModel.article_id;
    [self.navigationController pushVC:vc];
    

}
#pragma mark-------inputViewDelegate代理方法-----------

- (void)keyboardWillShow:(HXInputView *)inputView keyboardHeight:(CGFloat)keyboardHeight animationDuration:(NSTimeInterval)duration animationCurve:(UIViewAnimationCurve)animationCurve{
    
    //获取键盘的高度
    self.keyboardHeight = keyboardHeight;
    //动画弹出键盘和输入框
    [UIView animateKeyframesWithDuration:duration delay:0.0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        //输入框紧贴键盘
        self.inputView.bottom = SCREEN_HEIGHT - keyboardHeight - 30;
        
    } completion:^(BOOL finished) {
        
    }];

    
    
}


- (void)keyboardWillHide:(HXInputView *)inputView keyboardHeight:(CGFloat)keyboardHeight animationDuration:(NSTimeInterval)duration animationCurve:(UIViewAnimationCurve)animationCurve{
    [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{

        self.inputView.top = SCREEN_HEIGHT ;

    } completion:^(BOOL finished) {
      
        
    }];

}

//打赏
- (void)areward {

    HXArewardVC *vc = [HXArewardVC new];
    vc.article_id = self.articleModel.article_id;
    [self.navigationController pushVC:vc];
    
}
//发送评论
- (void)sendCommentAction {

    [[[HXarticleReviewAPI articlereviewAddWitharticle_id:self.articleModel.article_id review_content:self.inputView.inputView.text] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
    
        [self.inputView.inputView resignFirstResponder];
        
        }];
}
#pragma mark-------WKWebViewDelegate代理方法-----------
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    [LWActiveIncator showInView:self.view];

    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{

    

}
 //页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

    [LWActiveIncator hideInViwe:self.view];

    NSString *js = [NSString stringWithFormat:@"textnum(%@)",self.articleModel.article_id];
    NSLog(@"js---%@",js);
    [webView evaluateJavaScript:js completionHandler:^(id _Nullable, NSError * _Nullable error) {
        NSLog(@"error::%@",error);
    }];
    NSString *js1 = [NSString stringWithFormat:@"click(%@,%@)",self.loginModel.users_id?self.loginModel.users_id:@"0",[NSString stringWithFormat:@"%d",self.isLogin]];
    NSLog(@"js---%@",js1);
    [webView evaluateJavaScript:js1 completionHandler:^(id _Nullable, NSError * _Nullable error) {
        NSLog(@"error::%@",error);
    }];

}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{



}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"request*****%@",navigationAction.request.URL);
//    if ([[NSString stringWithFormat:@"%@",navigationAction.request.URL] containsString:@"https://www.baidu.com"]) {
//        [self areward];
//    }
    if ([[NSString stringWithFormat:@"%@",navigationAction.request.URL] containsString:@"https://cookie.pingxx.com/"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
    decisionHandler(WKNavigationActionPolicyAllow);
    }
}

//#pragma mark-------UIWebViewDelegate代理方法-----------
//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    
//    if ([[NSString stringWithFormat:@"%@",request.URL] containsString:@"https://www.baidu.com"]) {
//        [self areward];
//        return NO;
//    }
//    return YES;
//}
//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    
//    [LWActiveIncator showInView:self.view];
//    
//    
//}
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    
//    
//    [LWActiveIncator hideInViwe:self.view];
//    
//    NSString *js = [NSString stringWithFormat:@"textnum(%@)",self.articleModel.article_id];
//    NSLog(@"js---%@",js);
//    [webView stringByEvaluatingJavaScriptFromString:js];
//    NSString *js1 = [NSString stringWithFormat:@"click(%@,%@)",self.loginModel.users_id?self.loginModel.users_id:@"0",[NSString stringWithFormat:@"%d",self.isLogin]];
//    NSLog(@"js---%@",js1);
//    [webView stringByEvaluatingJavaScriptFromString:js1];
//    //WKWebView
//    //    [webView evaluateJavaScript:js completionHandler:^(id _Nullable, NSError * _Nullable error) {
//    //            NSLog(@"error::%@",error);
//    //        }];
//    
//}
@end
