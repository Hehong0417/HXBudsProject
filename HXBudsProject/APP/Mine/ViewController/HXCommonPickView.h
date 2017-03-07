//
//  HXCommonPickView.h
//  HXBudsProject
//
//  Created by n on 2017/3/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum : NSUInteger {
    HXCommonPickViewStyleDate,
    HXCommonPickViewStyleSex,
    
} HXCommonPickViewStyle;

@interface HXCommonPickView : UIView

@property(nonatomic,assign)  HXCommonPickViewStyle style;

@property(nonatomic,strong)  UIView *contentView;

@property (assign, nonatomic) BOOL animated;

@property(nonatomic,strong)  NSString *selectedSexItem;

@property(nonatomic,strong)  UIDatePicker *datePick;



@property(nonatomic,copy)  stringBlock completeBlock;


- (void)showPickViewAnimation:(BOOL)animated;
- (void)hidePickViewComplete:(void(^)())completeBlock;

@end
