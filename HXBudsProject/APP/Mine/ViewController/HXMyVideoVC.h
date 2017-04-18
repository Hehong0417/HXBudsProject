//
//  HXMyVideoVC.h
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VideoType) {
    myVideo,
    homeInfoVideo,
};

@interface HXMyVideoVC : UIViewController

@property(nonatomic,assign) VideoType videoType;

@end
