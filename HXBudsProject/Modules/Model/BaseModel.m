//
//  BaseModel.m
//  Bsh
//
//  Created by IMAC on 15/12/16.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

//- (NSString *)description {
//    
//    return [NSString stringWithFormat:@"%@\n%@", [super description], [self mj_keyValues]];
//}
//
//- (id)newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
//    if (oldValue == nil || oldValue == [NSNull null]) {
//        if (property.type.typeClass == [NSArray class]) {
//            return @[];
//        }
//        else if (property.type.typeClass == [NSDictionary class]) {
//            return @{};
//        }
////        }else if (property.type.typeClass == [NSNumber class]) {
////
////            return @0;
////        }
//        
//        return @"";
//    }
//    return oldValue;
//}
//
//#pragma mark - <BaseModelReadWriteProtocol>
//
//MJCodingImplementation
//
//+ (NSString *)filePath {
//    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    return [cachePath stringByAppendingPathComponent:NSStringFromClass(self.class)];
//}
//
//+ (instancetype)read {
//    NSString *filePath = [self filePath];
//    if (filePath && [[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//    }
//    return nil;
//}
//
//- (void)write {
//    NSString *filePath = [[self class] filePath];
//    if (filePath) {
//        BOOL isSuccess = [NSKeyedArchiver archiveRootObject:self toFile:filePath];
//        if (isSuccess) {
//            DDLogInfo(@"归档 %@ 成功", self.class);
//        }
//    }
//}

@end
