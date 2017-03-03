//
//  HXCourseOneVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseFourVC.h"
#import "HXCourseCommonView.h"


@interface HXCourseFourVC ()


@end

@implementation HXCourseFourVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kWhiteColor;
    
    HXCourseCommonView *commonView = [[HXCourseCommonView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT - 44)];
    [self.view addSubview:commonView];
    
    commonView.dataArr = @[@"钢琴",@"电子琴",@"古筝",@"大提琴",@"小提琴",@"架子鼓",@"吉他",@"尤克里里",@"二胡",@"萨克斯",@"手鼓"];
    
    

}

@end
