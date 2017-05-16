//
//  HXCurriSearchVC.h
//  HXBudsProject
//
//  Created by n on 2017/5/15.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXCurriSearchResultVC.h"
@interface HXCurriSearchVC : UIViewController
/** 搜索栏 */
@property (nonatomic, weak) UISearchBar *searchBar;
/** 热门标签头部 */
@property (nonatomic, weak) UILabel *hotSearchHeader;
/** 搜索结果 */
@property (nonatomic, strong) HXCurriSearchResultVC *searchResultVC;
/** 搜索建议是否隐藏 默认为：NO */
@property (nonatomic, assign) BOOL searchSuggestionHidden;
@end
