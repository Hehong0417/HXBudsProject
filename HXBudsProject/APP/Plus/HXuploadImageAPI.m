//
//  HXuploadImageAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/27.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXuploadImageAPI.h"

@implementation HXuploadImageAPI

+ (instancetype)uploadImageWithphotoFile:(NSData *)photoFile{

    HXuploadImageAPI *api = [[HXuploadImageAPI alloc] init];
    if (photoFile) {
        NetworkClientFile *file = [NetworkClientFile imageFileWithFileData:photoFile name:@"pic1"];
        api.uploadFile = @[file];
    }
   
    api.subUrl = API_GET_UPLOAD_IMAGE;
    
    return api;

}
@end
