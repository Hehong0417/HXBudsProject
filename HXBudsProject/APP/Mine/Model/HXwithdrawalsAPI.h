//
//  HXwithdrawalsAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXwithdrawalsAPI : BaseAPI

+ (instancetype)withdrawWithMoney:(NSString *)with_money with_acc:(NSString *)with_acc;

@end
