//
//  HXSearchSubjectVC.h
//  HXBudsProject
//
//  Created by n on 2017/4/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXSearchSubjectVC : UIViewController

//搜索结果
@property (nonatomic, copy) NSArray<NSString *> *searchResults;

@property (nonatomic, strong) UIView *hotSearchTagsContentView;


@end
