//
//  HXMyMessageModel.m
//  HXBudsProject
//
//  Created by n on 2017/5/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyMessageModel.h"

@implementation HXMyMessageModel
+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"varList":[HXMyMessageVarlistModel class]};
}
@end
@implementation HXMyMessageVarlistModel

@end
