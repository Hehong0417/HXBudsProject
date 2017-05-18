//
//  HXTeacherModel.h
//  HXBudsProject
//
//  Created by n on 2017/4/25.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@interface HXTeacherListModel : BaseModel

@property(nonatomic,strong) NSArray *varList;

@end

@interface HXteacherVarListModel : BaseModel

@property(nonatomic,copy) NSString *theteacher_id;
@property(nonatomic,copy) NSString *the_name;
@property(nonatomic,copy) NSString *hobby;
@property(nonatomic,copy) NSString *the_headportrait;
@property(nonatomic,copy) NSString *followState;
@property(nonatomic,copy) NSString *lng;//经度
@property(nonatomic,copy) NSString *lat;//经度
@property(nonatomic,copy) NSString *distance;//距离

@end
