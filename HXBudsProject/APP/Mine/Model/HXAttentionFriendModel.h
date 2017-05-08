//
//  HXAttentionFriendModel.h
//  HXBudsProject
//
//  Created by n on 2017/5/4.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@interface HXAttentionFriendModel : BaseModel

@property(nonatomic,strong) NSArray *varList;

@end
@interface HXAttentionFriendVarlistModel : BaseModel

@property(nonatomic,copy) NSString *headportrait;
@property(nonatomic,copy) NSString *hobby;
@property(nonatomic,copy) NSString *nickname;

@end
