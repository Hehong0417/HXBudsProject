//
//  HXOrganizationListModel.h
//  HXBudsProject
//
//  Created by n on 2017/5/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@interface HXOrganizationListModel : BaseModel
@property(nonatomic,strong) NSArray *varList;

@end
@interface HXOrganizationVarListModel : BaseModel
@property(nonatomic,copy) NSString *mechanism_id;
@property(nonatomic,copy) NSString *mechanism_name;
@property(nonatomic,copy) NSString *mechanism_logo;
@property(nonatomic,copy) NSString *mechanism_desc;
@property(nonatomic,copy) NSString *mechanism_lng;//经度
@property(nonatomic,copy) NSString *mechanism_lat;//经度
@property(nonatomic,copy) NSString *mechanism_address;
@property(nonatomic,copy) NSString *distance;//距离

@end
