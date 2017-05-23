//
//  HXSubjectVideoModel.h
//  HXBudsProject
//
//  Created by n on 2017/4/25.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@interface HXSubjectVideoListModel : BaseModel
@property(nonatomic,strong) NSArray *varList;

@end

@interface HXSubjectVideoModel : BaseModel
@property(nonatomic,copy) NSString *curriculum_id;
@property(nonatomic,copy) NSString *curriculum_price;
@property(nonatomic,copy) NSString *curr_picture;
@property(nonatomic,copy) NSString *curr_title;
@property(nonatomic,copy) NSString *read;
@property(nonatomic,copy) NSString *comment;
@property(nonatomic,copy) NSString *the_name;
@property(nonatomic,copy) NSString *The_headportrait;
@property(nonatomic,copy) NSString *when_long;
@property(nonatomic,copy) NSString *charge_status_text;
@property(nonatomic,copy) NSString *introduction;


@end
