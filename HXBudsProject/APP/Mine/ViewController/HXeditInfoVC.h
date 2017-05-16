//
//  HXeditInfoVC.h
//  HXBudsProject
//
//  Created by n on 2017/5/15.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^editItemBlock)(NSString *item);

@interface HXeditInfoVC : UIViewController
@property(nonatomic,strong) NSString *titleStr;
@property(nonatomic,assign) BOOL personIntroduce;
@property(nonatomic,copy) editItemBlock itemBlock;

@end
