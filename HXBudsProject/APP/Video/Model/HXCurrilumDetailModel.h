//
//  HXCurrilumDetailModel.h
//  HXBudsProject
//
//  Created by n on 2017/4/27.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@class HXCurrilumPdModel;

@interface HXCurrilumDetailModel : BaseModel

@property(nonatomic,strong) HXCurrilumPdModel *pd;

@end
@interface HXCurrilumPdModel : BaseModel
@property(nonatomic,copy) NSString *The_headportrait;
@property(nonatomic,copy) NSString *curr_picture;
@property(nonatomic,copy) NSString *curr_title;
@property(nonatomic,copy) NSString *curriculum_price;
@property(nonatomic,copy) NSString *the_name;
@property(nonatomic,copy) NSString *theteacher_id;
@property(nonatomic,copy) NSString *when_long;
@property(nonatomic,copy) NSString *read;
@property(nonatomic,copy) NSString *introduction;
@property(nonatomic,copy) NSString *mechanism_logo;
@property(nonatomic,copy) NSString *mechanism_id;
@property(nonatomic,copy) NSString *mechanism_name;


@end
