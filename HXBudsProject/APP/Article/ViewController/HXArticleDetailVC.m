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
#import "HXLoginVC.h"
#import "HXcollectionarticleAPI.h"
#import <UShareUI/UShareUI.h>


@interface HXArticleDetailVC ()<WKUIDelegate,WKNavigationDelegate,InputViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>

//@property WKWebViewJavascriptBridge* bridge;

@property (nonatomic, strong) HXInputView *inputView;

//键盘高度
@property (nonatomic, assign) CGFloat keyboardHeight;

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) HJLoginModel *loginModel;


@end

@implementation HXArticleDetailVC
//- (void) viewWillAppear: (BOOL)animated {
//    
//    //关闭键盘事件相应
//    [IQKeyboardManager sharedManager].enable = NO;
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
//
//}
//
//- (void) viewWillDisappear: (BOOL)animated {
//    
//    //打开键盘事件相应
//    [IQKeyboardManager sharedManager].enable = YES;
//    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
//
//}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kWhiteColor;

    //文章详情
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
     self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114) configuration:config];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:article_detail_url]];
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jianshu.com/p/f79589c21dc4"]];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
    //
    HXInformationCommentView *commentView = [[HXInformationCommentView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50-64, SCREEN_WIDTH, 50)];
    commentView.nav = self.navigationController;
    //收藏文章
    commentView.selectefinishBlock = ^(BOOL selected) {
        if (self.isLogin) {
            [[[HXcollectionarticleAPI collectionarticleWitharticle_id:self.articleModel.article_id state:selected?@"1":@"0"] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
                
            }];
        }else{
            [self.navigationController pushVC:[HXLoginVC new]];
        }
    };
    //分享
    [commentView.shareBtn setTapActionWithBlock:^{
        
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            
            [self shareVedioToPlatformType:platformType];
            
        }];
        
        
    }];
    [commentView lh_setCornerRadius:0 borderWidth:1 borderColor:KVCBackGroundColor];
    [self.view addSubview:commentView];
    
    //键盘弹出后的评论框
    self.inputView = [[HXInputView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 100)];
    self.inputView.backgroundColor = KVCBackGroundColor;
    self.inputView.delegate = self;
    [self.view addSubview:self.inputView];
    
    [self.inputView.sendBtn addTarget:self action:@selector(sendCommentAction) forControlEvents:UIControlEventTouchUpInside];
    

    UIButton *btn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 60, 60) target:self action:@selector(ActionClisk) image:nil title:@"评论" titleColor:kBlackColor font:FONT(14)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

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
//分享到不同平台
- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType
{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建视频内容对象
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:self.articleModel.article_title descr:self.articleModel.article_content thumImage:[UIImage imageNamed:self.articleModel.article_cover]];
    
    //设置视频网页播放地址
//    shareObject.videoUrl = video_testUrl;
    
    //            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}
- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

- (void)ActionClisk {
    
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
        self.inputView.bottom = SCREEN_HEIGHT - keyboardHeight-40;
        [self.inputView.inputView becomeFirstResponder];
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

    NSString *content =  [self disable_emoji:self.inputView.inputView.text];
    
    if (self.isLogin) {
        [[[HXarticleReviewAPI articlereviewAddWitharticle_id:self.articleModel.article_id review_content:content] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
            
            [self.inputView.inputView resignFirstResponder];
            
            NSString *js3 = [NSString stringWithFormat:@"refresh()"];
           
            [self.webView evaluateJavaScript:js3 completionHandler:^(id _Nullable, NSError * _Nullable error) {
                NSLog(@"error::%@",error);
            }];
            
        }];
    }else{
    
        [self.navigationController pushVC:[HXLoginVC new]];
    }
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
    if ([[NSString stringWithFormat:@"%@",navigationAction.request.URL] containsString:@"https://www.baidu.com"]) {
        [self areward];
        decisionHandler(WKNavigationActionPolicyCancel);

    }
    decisionHandler(WKNavigationActionPolicyAllow);

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
