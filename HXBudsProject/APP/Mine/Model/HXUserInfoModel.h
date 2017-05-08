//
//  HXUserInfoModel.h
//  HXBudsProject
//
//  Created by n on 2017/5/5.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@interface HXUserInfoModel : BaseModel

@property(nonatomic,copy) NSString *nickname;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *sex;
@property(nonatomic,copy) NSString *userdetails_id;
@property(nonatomic,copy) NSString *username;
@property(nonatomic,copy) NSString *hobby;
@property(nonatomic,copy) NSString *headportrait;
@property(nonatomic,copy) NSString *age;

@end
