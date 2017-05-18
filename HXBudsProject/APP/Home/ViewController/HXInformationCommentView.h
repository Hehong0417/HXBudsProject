//
//  HXInformationCommentView.h
//  HXBudsProject
//
//  Created by n on 2017/3/7.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^finishBlock)(BOOL selected);

@interface HXInformationCommentView : UIView

@property (strong, nonatomic)  UIButton *backBtn;
@property (strong, nonatomic)  UITextField *reViewTextField;
@property (strong, nonatomic)  UIButton *collectionBtn;
@property (strong, nonatomic)  UIButton *shareBtn;
@property (strong, nonatomic)  UIButton *sendBtn;
@property (copy, nonatomic)  finishBlock  selectefinishBlock;
@property (strong, nonatomic)  UINavigationController *nav;

@end
