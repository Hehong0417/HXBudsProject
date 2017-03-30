//
//  SMNavigationViewController.m
//  ShopingMall
//
//  Created by zhipeng-mac on 15/9/30.
//  Copyright (c) 2015年 zhipeng-mac. All rights reserved.
//

#import "HJNavigationController.h"
#import "AppDelegate.h"


@implementation UINavigationController (Extension)


// 是否支持自动转屏
- (BOOL)shouldAutorotate
{
    return [self.visibleViewController shouldAutorotate];
}
// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.visibleViewController supportedInterfaceOrientations];
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}






- (void)pushViewControllerWithStoryBoardName:(NSString *)storyBoardName identifier:(NSString *)identifier {
    
    UIViewController *controller = [UIViewController createFromStoryboardName:storyBoardName WithIdentifier:identifier];
    [self pushViewController:controller animated:YES];
}

- (void)pushVC:(UIViewController *)viewController {
    
    [self pushViewController:viewController animated:YES];
}

- (void)popVC {
    
    [self popViewControllerAnimated:YES];
}

- (void)popToVC:(UIViewController *)viewController {
    
    [self popToViewController:viewController animated:YES];

}

- (void)popToRootVC {
    
    [self popToRootViewControllerAnimated:YES];
}

@end

@interface HJNavigationController ()
@end



@implementation HJNavigationController


//第一次使用这个类的时候调用1次
+ (void)initialize
{
    // 设置UINavigationBarTheme
    [self setupNavigationBarTheme];
    
    // 设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
}

//设置UINavigationBarTheme主题
+ (void)setupNavigationBarTheme {
    
    UINavigationBar *appearance = [UINavigationBar appearance];

    //设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = kBlackColor;
    textAttrs[NSFontAttributeName] = JDNavigationFont;
    
    
    //设置导航栏背景

    //导航栏背景图片
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[(__bridge id)RGB(118,198,170).CGColor,(__bridge id)RGB(107,199,225).CGColor];
//    gradientLayer.locations = @[@0.2,@0.9];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(0, 1.0);
//    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
//    UIView *navView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
//    [navView.layer addSublayer:gradientLayer];
//    
//   UIImage *navImage = [navView lh_toImage];
    
    UIImage *navImage = [UIImage imageWithColor:kWhiteColor];
    //设置导航栏背景
    if (!iOS7){
        [appearance setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
        textAttrs[NSShadowAttributeName] = [[NSShadow alloc] init];
    }
    else {

        [appearance setBackgroundImage:navImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        textAttrs[NSShadowAttributeName] = [[NSShadow alloc] init];

    }
    [appearance setShadowImage:[UIImage new]];

    [appearance setTitleTextAttributes:textAttrs];
}

//设置UIBarButtonItem的主题
+ (void)setupBarButtonItemTheme
{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kBlackColor, NSForegroundColorAttributeName,[UIFont systemFontOfSize:18],NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    //    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:SWCommonColor, NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName,nil] forState:UIControlStateHighlighted];
    
    // 设置不可用状态(disable)的文字属性
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName,nil] forState:UIControlStateDisabled];
    /**自定义导航控制器返回按钮设置背景**/
    // 技巧: 为了让某个按钮的背景消失, 可以设置一张完全透明的背景图片
//    [appearance setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    /*
    //自定义返回按钮
    UIImage *backButtonImage = [[UIImage imageNamed:@"list_xiangqing"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 20, 0)];
    [appearance setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
     */
    
}

/**
 *  当导航控制器的view创建完毕就调用
 */
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    
}

- (void)showRightMenu
{
//    [self.frostedViewController presentMenuViewController];
}
#pragma mark Gesture recognizer

//- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
//{
////    [self.frostedViewController panGestureRecognized:sender];
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    // 判断是否为栈底控制器
    if (self.viewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        //设置导航子控制器按钮的加载样式，非栈底添加返回按钮
        //        UINavigationItem *vcBtnItem= [viewController navigationItem];
        //
        //        vcBtnItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithImageName:@"back_bt_7" highImageName:@"back_bt_7" title:[[self.childViewControllers lastObject] title] target:self action:@selector(back)];
    
    }
    
    [super pushViewController:viewController animated:YES];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
}



@end
