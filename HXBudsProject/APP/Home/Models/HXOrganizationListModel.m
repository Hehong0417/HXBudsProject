//
//  HXOrganizationListModel.m
//  HXBudsProject
//
//  Created by n on 2017/5/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOrganizationListModel.h"

@implementation HXOrganizationListModel

+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"varList":[HXOrganizationVarListModel class]};
}

@end
@implementation HXOrganizationVarListModel

@end
