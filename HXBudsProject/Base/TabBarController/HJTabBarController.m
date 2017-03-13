//
//  JDTabBarController.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/12.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "HJTabBarController.h"
#import "HJNavigationController.h"
#import "HJStoryBoardItem.h"

@interface HJTabBarController () <UITabBarControllerDelegate>

@property (nonatomic,strong) NSArray *tabBarItemTitles;
@property (nonatomic,strong) NSArray *tabBarItemNormalImages;
@property (nonatomic,strong) NSArray *tabBarItemSelectedImages;
@property (nonatomic,strong) NSArray *tabBarStoryBoardItems;




@end

@implementation HJTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //1.添加所有的自控制器
    [self addAllChildVcs];
    
    self.delegate = self;
    self.tabBar.tintColor=APP_COMMON_COLOR;
}

- (void)addAllChildVcs
{
    
    for (int i=0; i < self.tabBarStoryBoardItems.count; i++) {
        
        UIViewController *childVC = [self viewControllerWithStoryBoardItem:self.tabBarStoryBoardItems[i]];
        
        [self addOneChildVc:childVC title:self.tabBarItemTitles[i] imageName:self.tabBarItemNormalImages[i] selectedImageName:self.tabBarItemSelectedImages[i]];
    }
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}

- (UIViewController *)viewControllerWithStoryBoardItem:(HJStoryBoardItem *)storyBoardItem {
    
    
    UIViewController *controller = nil;
    
    if (storyBoardItem.viewControllerNonExist) {
        
        
        controller = (UIViewController *)[[NSClassFromString(storyBoardItem.Identifier) alloc]init];
        
        return controller;
    }

    
    controller = [UIViewController createFromStoryboardName:((HJStoryBoardItem *)storyBoardItem).storyBoardName WithIdentifier:((HJStoryBoardItem *)storyBoardItem).Identifier];
    
    return controller;
            
}

- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    //设置标题
    childVc.title = title;
    //设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
     [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -5)];
    //设置选中图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (iOS7) {
        //声明这张图用原图
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    //设置背景
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBar_bg"];
    //添加导航控制器
    if ([childVc isKindOfClass:[UINavigationController class]]) {
        
        [self addChildViewController:childVc];
        return;
    }
    HJNavigationController *nav = [[HJNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

+ (void)initialize
{
    //设置底部tabbar的主题样式
    UITabBarItem *appearance = [UITabBarItem appearance];
//    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:JDCommonColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
}

#pragma mark - Setter&Getter

- (NSArray *)tabBarItemTitles {
    
    if (!_tabBarItemTitles) {
        
        _tabBarItemTitles = @[ @"首页",
                               @"课程",
                               @"活动",
                               @"我的"];
    }
    
    return _tabBarItemTitles;
}

- (NSArray *)tabBarItemNormalImages {
    
    if (!_tabBarItemNormalImages) {
        
        _tabBarItemNormalImages = @[ @"home",
                                     @"course",
                                     @"activity",
                                     @"mine"];
    }
    
    return _tabBarItemNormalImages;
}

- (NSArray *)tabBarItemSelectedImages {
    
    if (!_tabBarItemSelectedImages) {
        
        _tabBarItemSelectedImages =  @[@"home_pre",
                                       @"course_pre",
                                       @"activity_pre",
                                       @"mine_pre"];    }
    
    return _tabBarItemSelectedImages;
}

- (NSArray *)tabBarStoryBoardItems {
    
    if (!_tabBarStoryBoardItems) {
        
        //
        HJStoryBoardItem *item1 = [HJStoryBoardItem itemWithStroyBoardName:@"HomePage" identifier:@"HXHomePageTVC" viewControllerNonExist:YES];
        HJStoryBoardItem *item2 = [HJStoryBoardItem itemWithStroyBoardName:@"Course" identifier:@"HXCourseListVC" viewControllerNonExist:YES];
        HJStoryBoardItem *item3 = [HJStoryBoardItem itemWithStroyBoardName:@"Activity" identifier:@"HXActinityVC" viewControllerNonExist:YES];
        HJStoryBoardItem *item4 = [HJStoryBoardItem itemWithStroyBoardName:@"PersonCenter" identifier:@"HXPersonCenterVC" viewControllerNonExist:YES];

        _tabBarStoryBoardItems = @[ item1,
                                    item2,
                                    item3,
                                    item4];
    }
    
    return _tabBarStoryBoardItems;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
