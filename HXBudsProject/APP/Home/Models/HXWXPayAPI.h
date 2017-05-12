//
//  HXWXPayAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/11.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXWXPayAPI : BaseAPI
+ (instancetype)wxPayWithopcash:(NSString *)opcash wxpaytype:(NSString *)wxpaytype;
@end
