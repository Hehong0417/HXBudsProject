//
//  HXMineLearnCell.h
//  HXBudsProject
//
//  Created by n on 2017/2/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HXMineLearnCellDelegate <NSObject>

- (void)LearnBtnActionWithIndex:(NSInteger)index;

@end

@interface HXMineLearnCell : UITableViewCell

@property(nonatomic,copy) id<HXMineLearnCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property(nonatomic,strong) NSString *leftImageStr;
@property(nonatomic,strong) NSString *rightImageStr;


+ (instancetype)initMineCellWithXib;

@end
