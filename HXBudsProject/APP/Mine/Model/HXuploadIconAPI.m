//
//  HXuploadIconAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/5.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXuploadIconAPI.h"

@implementation HXuploadIconAPI
+ (instancetype)uploadImageWithphotoFile:(NSData *)photoFile{
    
    HXuploadIconAPI *api = [[HXuploadIconAPI alloc] init];
    if (photoFile) {
        NetworkClientFile *file = [NetworkClientFile imageFileWithFileData:photoFile name:@"ico"];
        api.uploadFile = @[file];
    }
    api.subUrl = API_media_upload;
    
    return api;
    
}
@end
