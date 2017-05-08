//
//  HXTeachingTypeListModel.h
//  HXBudsProject
//
//  Created by n on 2017/5/5.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@interface HXTeachingTypeListModel : BaseModel
@property(nonatomic,strong) NSArray *varList;

@end
@interface HXTeachingTypeVarListModel : BaseModel
@property(nonatomic,copy) NSString *teachingtype_id;
@property(nonatomic,copy) NSString *type_name;
@end
