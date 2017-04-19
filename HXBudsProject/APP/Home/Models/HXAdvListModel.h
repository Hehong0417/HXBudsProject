//
//  HXAdvListModel.h
//  HXBudsProject
//
//  Created by n on 2017/4/18.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@class HXVarListModel;

@interface HXAdvListModel : BaseModel

@property(nonatomic,strong) NSArray *varList;

@end

@interface HXVarListModel : BaseModel

@property(nonatomic,copy) NSString *picture;

@end
