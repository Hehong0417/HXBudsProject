//
//  HXcurriculumreviewModel.h
//  HXBudsProject
//
//  Created by n on 2017/4/27.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@interface HXcurriculumreviewModel : BaseModel

@property(nonatomic,strong) NSArray *varList;

@end
@interface HXcurriculumreviewVarListModel : BaseModel
@property(nonatomic,strong) NSString *review_content;
@property(nonatomic,strong) NSString *Ctime;
@property(nonatomic,strong) NSString *fabulous;
@property(nonatomic,strong) NSString *star;
@end
