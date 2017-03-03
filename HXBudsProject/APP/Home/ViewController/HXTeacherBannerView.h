//
//  HXTeacherBannerView.h
//  HXBudsProject
//
//  Created by n on 2017/2/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HXTeacherBannerDelegate <NSObject>

- (void)buttonClickWithIndex:(NSInteger )index;

@end

@interface HXTeacherBannerView : UIView

@property (weak, nonatomic) IBOutlet UIButton *btn1;

@property (weak, nonatomic) IBOutlet UIButton *btn2;

+ (instancetype)initTeacherBannerViewWithXib;

@property(nonatomic,weak) id<HXTeacherBannerDelegate> delegate;


@end
