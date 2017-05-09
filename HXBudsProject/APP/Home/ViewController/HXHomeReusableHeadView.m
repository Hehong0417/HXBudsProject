//
//  HXHomeReusableHeadView.m
//  HXBudsProject
//
//  Created by n on 2017/4/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXHomeReusableHeadView.h"
#import "HXSubjectVideoVC.h"
#import "JKCustomAlertView.h"
#import "HXFindGroupSGVC.h"
#import "HXFamousTeacherSGVC.h"

@interface HXHomeReusableHeadView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)  UIView *findView;

@end


@implementation HXHomeReusableHeadView

- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup {

    _imageURLStringsGroup = imageURLStringsGroup;
    self.cycleSrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(152))];
    self.cycleSrollView.infiniteLoop = YES;
    self.cycleSrollView.placeholderImage=[UIImage imageNamed:@"homepagebannerplaceholder"];
    self.cycleSrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    self.cycleSrollView.autoScrollTimeInterval = 2.0; // 轮播时间间隔，默认1.0秒，可自定义
    self.cycleSrollView.delegate = self;

    self.cycleSrollView.imageURLStringsGroup = imageURLStringsGroup.count?imageURLStringsGroup:[self getImageURLGroup];
    
    [self addSubview:self.cycleSrollView];
    
    //找名师、找课程
    self.findView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cycleSrollView.frame), SCREEN_WIDTH, WidthScaleSize_H(85))];
    XYQButton  *findCurriLumBtn = [XYQButton ButtonWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH-1)/2,WidthScaleSize_H(85)) imgaeName:@"kecheng" titleName:@"找机构" contentType:TopImageBottomTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:RGB(101, 101, 101) fontsize:12] tapAction:^(XYQButton *button) {
        
        HXFindGroupSGVC *vc = [HXFindGroupSGVC new];
        [self.nav pushVC:vc];
        
    }];
    XYQButton  *findTeacherBtn = [XYQButton ButtonWithFrame:CGRectMake(CGRectGetMaxX(findCurriLumBtn.frame)+1,0, (SCREEN_WIDTH-1)/2,WidthScaleSize_H(85)) imgaeName:@"mingshi" titleName:@"找名师" contentType:TopImageBottomTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:RGB(101, 101, 101) fontsize:12] tapAction:^(XYQButton *button) {
        
        HXFamousTeacherSGVC *vc = [HXFamousTeacherSGVC new];
        [self.nav pushVC:vc];
    }];
    //分隔线
    UIView *downLine = [UIView lh_viewWithFrame:CGRectMake(CGRectGetMaxX(findCurriLumBtn.frame), WidthScaleSize_H(21), 1, WidthScaleSize_H(85)- WidthScaleSize_H(21)) backColor:RGB(227, 227, 227)];
    
    [self.findView addSubview:findCurriLumBtn];
    [self.findView addSubview:findTeacherBtn];
    [self.findView addSubview:downLine];
    
    [self addSubview:self.findView];
    
}
- (void)layoutSubviews{
    
//    UIView *categoryView = [UIView lh_viewWithFrame:CGRectMake(0, CGRectGetMaxY(self.findView.frame), SCREEN_WIDTH, 40) backColor:kWhiteColor];
//    //分类图片
//    UIImageView *categoryImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 10, 40)];
//    categoryImageV.image = [UIImage imageNamed:@"hot"];
//    categoryImageV.contentMode = UIViewContentModeLeft;
//    //    categoryImageV.backgroundColor = kOrangeColor;
//    [categoryView addSubview:categoryImageV];
//    
//    
//    CGSize nameSize = [self.headtitle lh_sizeWithFont:[UIFont systemFontOfSize:self.labFont] constrainedToSize:CGSizeMake(SCREEN_WIDTH, 30)];
//    //标题
//    UILabel *headTitleLab = [UILabel lh_labelWithFrame:CGRectMake(25, 0, nameSize.width, 40) text:self.headtitle textColor:kBlackColor font:FONT(self.labFont) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
//    [categoryView addSubview:headTitleLab];
//    
//    //描述
//    UILabel *discribLab = [UILabel lh_labelWithFrame:CGRectMake(CGRectGetMaxX(headTitleLab.frame)+10, 0, 200, 40) text:self.discribText textColor:RGB(186, 186, 186) font:FONT(12) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
//    [categoryView addSubview:discribLab];
//    
//    XYQButton *changeBtn = [XYQButton ButtonWithFrame:CGRectMake(SCREEN_WIDTH - WidthScaleSize_W(80), 2, WidthScaleSize_W(80), 40) imgaeName:self.imageName titleName:self.rightBtnTitle contentType:self.contentType buttonFontAttributes:self.btnFontAttributes tapAction:^(XYQButton *button) {
//        
//        [self.nav pushVC:self.vc];
//
//    }];
////    changeBtn.enabled = NO;
//    self.rightBtn = changeBtn;
//    [categoryView addSubview:changeBtn];
//    [self addSubview:categoryView];
//

}

- (NSArray *)getImageURLGroup {

//             NSArray *imageURLGroup = @[
//                                                                            @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1402/221/421883372/88115/8cc2231a/55815835N35a44559.jpg",
//                                                                            @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t976/208/1221678737/91179/5d7143d5/5588e849Na2c20c1a.jpg",
//                                                                            @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t805/241/1199341035/289354/8648fe55/5581211eN7a2ebb8a.jpg",
//                                                                            @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1606/199/444346922/48930/355f9ef/55841cd0N92d9fa7c.jpg",
//                                                                            @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1609/58/409100493/49144/7055bec5/557e76bfNc065aeaf.jpg",
//                                                                            @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t895/234/1192509025/111466/512174ab/557fed56N3e023b70.jpg",
//                                                                            ];
    NSArray *imageURLGroup = @[@"1",@"2",@"3"];
    return imageURLGroup;
    

}
//- (SDCycleScrollView *)setCycleSrollViewWithFrame:(CGRect)frame{
//    
////         NSArray *imagesURLStrings = @[
////                                                                        @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1402/221/421883372/88115/8cc2231a/55815835N35a44559.jpg",
////                                                                        @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t976/208/1221678737/91179/5d7143d5/5588e849Na2c20c1a.jpg",
////                                                                        @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t805/241/1199341035/289354/8648fe55/5581211eN7a2ebb8a.jpg",
////                                                                        @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1606/199/444346922/48930/355f9ef/55841cd0N92d9fa7c.jpg",
////                                                                        @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1609/58/409100493/49144/7055bec5/557e76bfNc065aeaf.jpg",
////                                                                        @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t895/234/1192509025/111466/512174ab/557fed56N3e023b70.jpg",
////                                                                        @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t835/313/1196724882/359493/b53c7b70/5581392cNa08ff0a9.jpg",
////                                                                        @"http://img30.360buyimg.com/mobilecms/s480x180_jfs/t898/15/1262262696/95281/57d1f12f/558baeb4Nbfd44d3a.jpg"
////                                                                        ];
////    
//   
//        //  //
//    SDCycleScrollView  *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame imageNamesGroup:self.cycleSrollView.imageURLStringsGroup];
//    
//    scrollView.infiniteLoop = YES;
//    scrollView.placeholderImage=[UIImage imageNamed:@"homepagebannerplaceholder"];
//    scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
//    scrollView.autoScrollTimeInterval = 2.0; // 轮播时间间隔，默认1.0秒，可自定义
//    //
//    ////    模拟加载延迟
//    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    //        _cycleSrollView.imageURLStringsGroup = imagesURLStrings;
//    //    });
//    return scrollView;
//}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    JKCustomAlertView *jkAlert = [[JKCustomAlertView alloc]initWithJKAlertType:JKAlertTypeOneTextField contentView:self];
    [jkAlert show];
    
}


@end
