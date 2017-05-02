//
//  HXTeacherDetailModel.h
//  HXBudsProject
//
//  Created by n on 2017/4/25.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@class HXPdModel;

@interface HXTeacherDetailModel : BaseModel

@property(nonatomic,strong) HXPdModel *pd;

@end

@interface HXPdModel : BaseModel

@property(nonatomic,copy) NSString *nickname;
@property(nonatomic,copy) NSString *followtenum;
@property(nonatomic,copy) NSString *the_headportrait;
@property(nonatomic,copy) NSString *hobby;

@end
