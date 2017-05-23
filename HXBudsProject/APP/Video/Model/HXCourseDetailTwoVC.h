//
//  HXCourseDetailTwoVC.h
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//


//#import "SegmentPageBaseViewController.h"
typedef void(^didselectBlock)(NSString *urlStr);

@protocol CourseDetailTwoDelegate <NSObject>

- (void)categoryDidSelectIndex:(NSString *)urlStr;

@end

@interface HXCourseDetailTwoVC : UIViewController
@property (nonatomic, strong)NSString * curriculum_id;

@property (nonatomic, copy) id <CourseDetailTwoDelegate> delegate;
@property (nonatomic, copy) didselectBlock didselectBlock;


@end
