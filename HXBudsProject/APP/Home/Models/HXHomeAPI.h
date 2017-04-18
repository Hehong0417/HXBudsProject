//
//  HXHomeAPI.h
//  HXBudsProject
//
//  Created by n on 2017/4/13.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXHomeAPI : BaseAPI

+(instancetype)getHomeInfoWithPage:(NSNumber *)page rows:(NSNumber *)rows;

@end
