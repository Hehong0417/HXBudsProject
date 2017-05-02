//
//  HXuploadImageAPI.h
//  HXBudsProject
//
//  Created by n on 2017/4/27.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXuploadImageAPI : BaseAPI
+ (instancetype)uploadImageWithphotoFile:(NSData *)photoFile;

@end
