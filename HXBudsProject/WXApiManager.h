//
//  WXApiManager.h
//  HXBudsProject
//
//  Created by n on 2017/5/25.
//  Copyright © 2017年 n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@protocol WXApiManagerDelegate <NSObject>
@optional

- (void)managerDidRecvGetResp:(BaseResp *)resp;

@end

@interface WXApiManager : NSObject<WXApiDelegate>

@property (nonatomic, assign) id<WXApiManagerDelegate> delegate;

+(instancetype)shareManager;

@end
