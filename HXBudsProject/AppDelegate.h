//
//  AppDelegate.h
//  HXBudsProject
//
//  Created by n on 2017/2/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenShotView.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) ScreenShotView *screenshotView;
+(AppDelegate *)shareAppDelegate;

@end

