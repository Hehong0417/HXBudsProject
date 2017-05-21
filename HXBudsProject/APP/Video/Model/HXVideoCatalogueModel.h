//
//  HXVideoCatalogueModel.h
//  HXBudsProject
//
//  Created by n on 2017/4/26.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@interface HXVideoCatalogueModel : BaseModel

@property(nonatomic,strong) NSArray *varList;

@end
@interface HXCataloguePdModel : BaseModel
@property(nonatomic,copy) NSString *curr_title;
@property(nonatomic,copy) NSString *curriculum_id;
@property(nonatomic,copy) NSString *videos_file;
@property(nonatomic,copy) NSString *videos_id;
@property(nonatomic,copy) NSString *videos_long;
@property(nonatomic,copy) NSString *videos_order;
@property(nonatomic,copy) NSString *videos_title;

@end
