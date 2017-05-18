//
//  HXMyMessageModel.h
//  HXBudsProject
//
//  Created by n on 2017/5/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@interface HXMyMessageModel : BaseModel
@property(nonatomic,strong) NSArray *varList;

@end
@interface HXMyMessageVarlistModel : BaseModel
@property(nonatomic,strong) NSString *ctime;
@property(nonatomic,strong) NSString *notification_title;
@property(nonatomic,strong) NSString *systemnotification_id;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *watch_status;
@end
