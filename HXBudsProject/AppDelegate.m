//
//  AppDelegate.m
//  HXBudsProject
//
//  Created by n on 2017/2/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
#import <AVFoundation/AVFoundation.h>
#import "HXLoginVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"


#define USHARE_DEMO_APPKEY  @"58cb57441061d270900022bd"
//#define Wechat_AppKey  @"wx6bf938fef8cc9fd2"
#define Wechat_AppKey  @"wxdc1e388c3822c80b"
#define Wechat_appSecret  @"3baf1193c85774b3fd9d18447d76cab0"

#define QQ_AppKey  @"1105821097"

#define Weibo_appKey  @"3921700954"
#define Weibo_appSecret  @"04b48b094faeb16683c32669824ebdad"

//// 引入JPush功能所需头文件
//#import "JPUSHService.h"
//// iOS10注册APNs所需头文件
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//#import <UserNotifications/UserNotifications.h>
//#endif
//
//#define JPush_APPKEY  @"58cb57441061d270900022bd"

@interface AppDelegate ()<UIApplicationDelegate,WXApiDelegate>

@end

@implementation AppDelegate

-(BOOL)shouldAutorotate{
    return NO;
}
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    //配置 IQKeyboardManager
    [self IQKeyboardManagerConfig];
    
    //配置友盟
    [self UMSocialConfig];
    
    
    //支付方式配置
    [self payWayConfig];
    
    
    
    //    [self JpushConfigWithOptions:launchOptions];
    
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController= [[HJTabBarController alloc]init];
    
    return YES;
}
- (void)IQKeyboardManagerConfig{
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    [manager setEnable:YES];
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar =YES; // 控制是否显示键盘上的工具条
    manager.keyboardDistanceFromTextField = 50;
    
}
- (void)payWayConfig{

    //向微信注册wxd930ea5d5a258f4f
    [WXApi registerApp:Wechat_AppKey ];



}
//- (void)JpushConfigWithOptions:(NSDictionary *)launchOptions{
//
//    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        // 可以添加自定义categories
//        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
//        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
//    }
//    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//   NSString *channel = @"App Store";
//    BOOL isProduction = 0;
//    [JPUSHService setupWithOption:launchOptions appKey:JPush_APPKEY
//                          channel:channel
//                 apsForProduction:isProduction
//            advertisingIdentifier:nil];
//}
- (void)UMSocialConfig{
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    [self configUSharePlatforms];
   
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:Wechat_AppKey appSecret:Wechat_appSecret redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:Wechat_AppKey appSecret:Wechat_appSecret redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_AppKey  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:QQ_AppKey  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:Weibo_appKey  appSecret:Weibo_appSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
}

//设置系统回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响----友盟-------
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
       //其他SDK如支付宝回调
        //微信SDK
        return [WXApi handleOpenURL:url delegate:self];
        
    }
    return result;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{

    //微信SDK
    return [WXApi handleOpenURL:url delegate:self];
    
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
        // ------支付SDK的回调-------
        if ([url.host isEqualToString:@"safepay"]) {
            
            // 支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
            
            // 授权跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                // 解析 auth code
                NSString *result = resultDic[@"result"];
                NSString *authCode = nil;
                if (result.length>0) {
                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                    for (NSString *subResult in resultArr) {
                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                            authCode = [subResult substringFromIndex:10];
                            break;
                        }
                    }
                }
                NSLog(@"授权结果 authCode = %@", authCode?:@"");
            }];
        }
        // ----------微信SDK---------
        
        
        
        //---------------------------
    }
    return result;
}
//**********//
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
