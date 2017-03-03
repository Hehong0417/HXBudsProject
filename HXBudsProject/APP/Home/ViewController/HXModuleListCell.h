//
//  HXModuleListCell.h
//  HXBudsProject
//
//  Created by n on 2017/2/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HXModuleListDelegate <NSObject>

- (void)btnClickWithIndex:(NSInteger)index;

@end

@interface HXModuleListCell : UITableViewCell

@property(nonatomic,weak) id<HXModuleListDelegate> delegate;

@end
