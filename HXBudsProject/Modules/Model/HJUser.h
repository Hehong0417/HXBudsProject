//
//  HJUser.h
//  Bsh
//
//  Created by IMAC on 15/12/25.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "BaseModel.h"
@interface HJLoginModel : BaseModel
@property (nonatomic, strong) NSNumber *isFirstLogin;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *pwd;
@end

@interface HJUser : BaseModel {
    
    HJLoginModel *_userModel;
}

singleton_h(User)

@property (nonatomic, strong) HJLoginModel *loginModel;

@property (nonatomic, assign) BOOL isRememberPwd;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) BOOL isLogin;

@end
