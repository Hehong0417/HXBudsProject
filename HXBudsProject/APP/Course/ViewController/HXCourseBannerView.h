//
//  HXCourseBannerView.h
//  HXBudsProject
//
//  Created by n on 2017/2/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HXCourseBannerDelegate <NSObject>

- (void)courseBannerBtnClickWithIndex:(NSInteger)index;

@end

@interface HXCourseBannerView : UIView
@property(nonatomic,weak) id<HXCourseBannerDelegate>delegate;

@end
