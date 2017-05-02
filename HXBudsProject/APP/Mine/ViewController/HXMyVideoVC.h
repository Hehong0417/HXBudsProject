//
//  HXMyVideoVC.h
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXSubjectVideoListModel.h"

typedef NS_ENUM(NSUInteger, VideoType) {
    mineVideo,//我收藏的视频
    teacherVideo,//老师动态的视频
};

@interface HXMyVideoVC : UIViewController

@property(nonatomic,assign) VideoType videoType;

@property (nonatomic, strong) HXSubjectVideoListModel *SubjectVideoListModel;

@end
