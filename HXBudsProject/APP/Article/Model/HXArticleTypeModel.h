//
//  HXArticleTypeModel.h
//  HXBudsProject
//
//  Created by n on 2017/5/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@interface HXArticleTypeModel : BaseModel

@property(nonatomic,strong) NSArray *varList;

@end
@interface HXArticleTypeVarlistModel : BaseModel
@property(nonatomic,copy) NSString *articletype_name;
@property(nonatomic,copy) NSString *articletype_id;
@end
