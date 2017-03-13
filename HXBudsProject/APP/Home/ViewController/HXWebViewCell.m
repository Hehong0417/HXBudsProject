
//
//  HXWebViewCell.m
//  HXBudsProject
//
//  Created by n on 2017/3/7.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXWebViewCell.h"

@interface HXWebViewCell ()<WKUIDelegate,WKNavigationDelegate>

@end

@implementation HXWebViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,350)];
        self.webView = webView;
        self.webView.UIDelegate = self;
        self.webView.navigationDelegate = self;
        [self.contentView addSubview:webView];
        
    }
    return self;
}
- (void)setUrlStr:(NSString *)urlStr {

    _urlStr = urlStr;

    NSURL *url = [NSURL URLWithString:urlStr];

    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:request];
    
    
    
}

//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//
//    
//    [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        
//        
//        CGFloat sizeHeight = [result floatValue];
//        
////        
////        CGRect frame = webView.frame;
////            frame.size.height = sizeHeight;
////        webView.frame = frame;
//
//        NSLog(@"sizeHeight = %.2f",sizeHeight);
//
//        
//    }];

//    CGSize size = [webView sizeThatFits:CGSizeZero];
//    webView.frame = frame;
    
 
//}

@end
