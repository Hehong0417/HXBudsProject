//
//  UIViewController+AOP.m
//  Bsh
//
//  Created by IMAC on 15/12/16.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "UIViewController+AOP.h"
#import <Aspects/Aspects.h>
#import "HXMessageVC.h"
#import "HXSearchViewController.h"
#import "HXSearchVC.h"

@implementation UIViewController (AOP)

/**
 *  AOP返回按钮
 *
 *  @return button
 */
+ (XYQButton *)aopBackButton {
    
    XYQButton *backButton = [XYQButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 30, 44)];
    UIImage *image = [UIImage imageNamed:@"back_gray"];
    [backButton setImage:image forState:UIControlStateNormal];
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    [backButton setTitleRectForContentRect:CGRectZero imageRectForContentRect:CGRectMake(-5, (backButton.lh_height-imageHeight)/2.0, imageWidth, imageHeight)];
    return backButton;
}
#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(HXSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

+ (void)load{
    
    //view did load
    [[self class] aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info) {
        
        UIViewController *controller = [info instance];

        __weak UIViewController *weakController = controller;

        //导航栏返回按钮设置
        if ([NSStringFromClass([controller class]) hasPrefix:@"HX"] &&
            ![controller isKindOfClass:NSClassFromString(@"HXHomeCVC")] &&
            ![controller isKindOfClass:NSClassFromString(@"HXCourseListVC")] &&
            ![controller isKindOfClass:NSClassFromString(@"HXPersonCenterVC")] &&
            ![controller isKindOfClass:NSClassFromString(@"HJNavigationController")] &&
            ![controller isKindOfClass:NSClassFromString(@"HXOrganizationDetailTVC")] &&
            ![controller isKindOfClass:NSClassFromString(@"HJTabBarController")] &&
            ![controller isKindOfClass:NSClassFromString(@"HXActinityVC")]&&
            ![controller isKindOfClass:NSClassFromString(@"HXSearchViewController")]&&
              ![controller isKindOfClass:NSClassFromString(@"HXChooseSujectVC")]) {
        
            //Log 视图加载
//            DDLogInfo(@"%@-------------视图加载完毕------------",controller);
            
            //tableViewController尾部设置
            if ([controller isKindOfClass:[UITableViewController class]]) {
                
                ((UITableViewController *)controller).tableView.tableFooterView = [UIView new];
            }
            
            // 控制器背景颜色
            [controller.view setBackgroundColor:KVCBackGroundColor];
            
            __weak UIViewController *weakController = controller;
            // 返回按钮
            XYQButton * backButton = [self aopBackButton];
            [backButton setTapActionWithBlock:^{
                  [weakController.navigationController popViewControllerAnimated:YES];
            }];
            controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        }
        if ([NSStringFromClass([controller class]) hasPrefix:@"HX"] && ([controller isKindOfClass:NSClassFromString(@"HXHomeCVC")]||[controller isKindOfClass:NSClassFromString(@"HXArticleVC")]||[controller isKindOfClass:NSClassFromString(@"HXPersonCenterVC")]||[controller isKindOfClass:NSClassFromString(@"HXVideoCVC")])) {
            
            XYQButton *searchBtn = [XYQButton ButtonWithFrame:CGRectMake(0, 0, 44, 60) imgaeName:@"search" titleName:@"" contentType:LeftTitleRightImage buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kWhiteColor fontsize:14] tapAction:^(XYQButton *button) {
              
         //*************搜 索************//
                // 1.创建热门搜索
                NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
                // 2. 创建控制器
                HXSearchViewController *searchViewController = [HXSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索" didSearchBlock:^(HXSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
                    // 开始搜索执行以下代码
                    // 如：跳转到指定控制器
//                    [searchViewController.navigationController pushViewController:[[HXSearchVC alloc] init] animated:YES];
                }];
               //3.设置风格
                searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格根据选择
                searchViewController.searchHistoryStyle = PYSearchHistoryStyleDefault;
                // 4. 设置代理
                searchViewController.delegate = self;
                searchViewController.searchSuggestions = @[@[@"视频1",@"视频2"],@[@"文章1",@"文章2"]];
                
                [controller.navigationController pushVC:searchViewController];

          //****************************//
    
            }];
            
            UIImage *image = [UIImage imageNamed:@"search"];
            [searchBtn setImage:image forState:UIControlStateNormal];
            CGFloat imageWidth = image.size.width;
            CGFloat imageHeight = image.size.height;
             [searchBtn setTitleRectForContentRect:CGRectZero imageRectForContentRect:CGRectMake(-5, (searchBtn.lh_height-imageHeight)/2.0, imageWidth, imageHeight)];
           
            controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
            
            XYQButton *messageBtn = [XYQButton ButtonWithFrame:CGRectMake(0, 0, 44, 60) imgaeName:@"message" titleName:@"" contentType:LeftTitleRightImage buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kWhiteColor fontsize:14] tapAction:^(XYQButton *button) {
                
                [controller.navigationController pushVC:[HXMessageVC new]];

            }];
            UIImage *image2 = [UIImage imageNamed:@"message"];
            [messageBtn setImage:image2 forState:UIControlStateNormal];
            CGFloat imageWidth2 = image2.size.width;
            CGFloat imageHeight2 = image2.size.height;
            [messageBtn setTitleRectForContentRect:CGRectZero imageRectForContentRect:CGRectMake(10, (messageBtn.lh_height-imageHeight)/2.0+5, imageWidth2, imageHeight2)];
            
            controller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:messageBtn];

        }
        
        
    } error:NULL];
    
    //view will appear 导航栏隐藏控制
    [[self class] aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info, BOOL animated) {
        
        UIViewController *controller = [info instance];
        
        if ([NSStringFromClass([controller class]) hasPrefix:@"HX"] && ([controller isKindOfClass:NSClassFromString(@"HXRegisterVC")]||[controller isKindOfClass:NSClassFromString(@"HXLoginVC")]||[controller isKindOfClass:NSClassFromString(@"HXCommitPassWordVC")]||[controller isKindOfClass:NSClassFromString(@"HXActivityDetailVC")]||[controller isKindOfClass:NSClassFromString(@"HXPersonCenterVC")])) {
            
            [controller.navigationController setNavigationBarHidden:YES animated:YES];
            
        }else{
            
            [controller.navigationController setNavigationBarHidden:NO animated:YES];
        }
        

   } error:NULL];
    
    //dealloc 观察控制器内存释放
    [[self class] aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info) {
        
        UIViewController *controller = [info instance];
        
        if ([NSStringFromClass([controller class]) hasPrefix:@"HX"]) {
            
            //Log 控制器释放
//            DDLogInfo(@"%@-------------控制器释放完毕------------",controller);
        }
        
    } error:NULL];
}

/* Method Swizzling
 + (void)load {   static dispatch_once_t onceToken;  dispatch_once(&onceToken, ^{
 Class class = [self class];    // When swizzling a class method, use the following:
 // Class class = object_getClass((id)self);
 swizzleMethod(class, @selector(viewDidLoad), @selector(aop_viewDidLoad));
 swizzleMethod(class, @selector(viewDidAppear:), @selector(aop_viewDidAppear:));
 swizzleMethod(class, @selector(viewWillAppear:), @selector(aop_viewWillAppear:));
 swizzleMethod(class, @selector(viewWillDisappear:), @selector(aop_viewWillDisappear:));
 });
 } void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)   {
 Method originalMethod = class_getInstanceMethod(class, originalSelector);
 Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);BOOL didAddMethod =
 class_addMethod(class,
 originalSelector,
 method_getImplementation(swizzledMethod),
 method_getTypeEncoding(swizzledMethod));if (didAddMethod) {
 class_replaceMethod(class,
 swizzledSelector,
 method_getImplementation(originalMethod),
 method_getTypeEncoding(originalMethod));
 } else {
 method_exchangeImplementations(originalMethod, swizzledMethod);
 }
 }
 - (void)aop_viewDidAppear:(BOOL)animated {
 [self aop_viewDidAppear:animated];
 
 
 }
 
 -(void)aop_viewWillAppear:(BOOL)animated {
 [self aop_viewWillAppear:animated];
 #ifndef DEBUG
 //    [MobClick beginLogPageView:NSStringFromClass([self class])];
 #endif
 }
 -(void)aop_viewWillDisappear:(BOOL)animated {
 [self aop_viewWillDisappear:animated];
 #ifndef DEBUG
 
 //    [MobClick endLogPageView:NSStringFromClass([self class])];
 #endif
 }
 - (void)aop_viewDidLoad {
 [self aop_viewDidLoad];
 if ([self isKindOfClass:[UINavigationController class]]) {
 UINavigationController *nav = (UINavigationController *)self;
 nav.navigationBar.translucent = NO;
 //        nav.navigationBar.barTintColor = GLOBAL_NAVIGATION_BAR_TIN_COLOR;
 nav.navigationBar.tintColor = [UIColor whiteColor];    NSDictionary *titleAtt = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
 [[UINavigationBar appearance] setTitleTextAttributes:titleAtt];
 [[UIBarButtonItem appearance]
 setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
 forBarMetrics:UIBarMetricsDefault];
 }
 //    self.view.backgroundColor = [UIColor whiteColor];self.navigationController.interactivePopGestureRecognizer.delegate = (id<uigesturerecognizerdelegate>)self;
 }
 */


@end
