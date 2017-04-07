//
//  HXGradeCommentCell.h
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HXGradeCommentCellDelegate <NSObject>

- (void)gradeCommentStarAction:(UIButton *)button;

@end

@interface HXGradeCommentCell : UITableViewCell

@property(nonatomic,weak) id <HXGradeCommentCellDelegate> delegate;

@end
