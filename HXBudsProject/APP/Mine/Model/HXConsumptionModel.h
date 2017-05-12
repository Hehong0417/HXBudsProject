//
//  HXConsumptionModel.h
//  HXBudsProject
//
//  Created by n on 2017/5/11.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@interface HXConsumptionModel : BaseModel

@property(nonatomic,strong) NSArray *varList;

@end
@interface HXConsumptionVarListModel : BaseModel
@property(nonatomic,copy) NSString *users_id;
@property(nonatomic,copy) NSString *tran_money;
@property(nonatomic,copy) NSString *transaction_id;
@property(nonatomic,copy) NSString *ctime;

@end
