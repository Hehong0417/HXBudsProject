//
//  HXArticleCellOne.h
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXArticleCellOne : UITableViewCell

@property(nonatomic,strong) UINavigationController *vc;

- (void)setSubjectArr:(NSArray *)subjectArr isViewMore:(BOOL) isViewMore cellHeight:(float)cellHeight;



@end
