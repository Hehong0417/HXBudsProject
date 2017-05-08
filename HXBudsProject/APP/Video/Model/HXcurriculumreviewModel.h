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
@property(nonatomic,strong) NSString *ctime;
@property(nonatomic,strong) NSString *fabulous;
@property(nonatomic,strong) NSString *star;
@property(nonatomic,strong) NSString *headportrait;
@property(nonatomic,strong) NSString *nickname;
@property(nonatomic,strong) NSString *curriculumreview_id;



@end
