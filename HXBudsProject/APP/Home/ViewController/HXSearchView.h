//
//  HXSearchVC.h
//  HXBudsProject
//
//  Created by n on 2017/2/21.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXSearchView : UIView

@property(nonatomic,strong)UINavigationController *vc;

@property(nonatomic,strong) UITextField *searchText;


- (void)showAnimated:(BOOL)animated;
- (void)av_addSuperViews;
- (void)av_removeSubviews;

@end
