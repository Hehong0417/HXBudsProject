//
//  HXOrganizationDeetailModel.h
//  HXBudsProject
//
//  Created by n on 2017/5/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@class HXOrganizationPdModel;

@interface HXOrganizationDeetailModel : BaseModel

@property(nonatomic,strong) HXOrganizationPdModel *pd;

@end
@interface HXOrganizationPdModel : BaseModel

@property(nonatomic,copy) NSString *mechanism_id;
@property(nonatomic,copy) NSString *mechanism_name;
@property(nonatomic,copy) NSString *mechanism_logo;
@property(nonatomic,copy) NSString *livepicture;
@property(nonatomic,copy) NSString *mechanism_desc;
@property(nonatomic,copy) NSString *mechanism_address;
@property(nonatomic,copy) NSString *mechanism_Lng;//经度
@property(nonatomic,copy) NSString *mechanism_Lat;//经度

@end
