//
//  HXWebViewCell.h
//  HXBudsProject
//
//  Created by n on 2017/3/7.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface HXWebViewCell : UITableViewCell

@property(nonatomic,strong)WKWebView *webView;

@property(nonatomic,strong)NSString *urlStr;

@end
