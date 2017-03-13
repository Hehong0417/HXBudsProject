//
//  HXCourseHeadView.h
//  HXBudsProject
//
//  Created by n on 2017/2/20.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HXCourseHeadViewDelegate <NSObject>

- (void)courseHeadViewSegmentSelectActionWithIndex:(NSInteger)index;

@end


@interface HXCourseHeadView : UIView

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *chooseBgView;

@property(weak,nonatomic) id<HXCourseHeadViewDelegate> delegate;


+ (instancetype)initCourseHeadViewWithXib;

@end
