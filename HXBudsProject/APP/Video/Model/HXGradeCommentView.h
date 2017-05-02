//
//  HXGradeCommentView.h
//  HXBudsProject
//
//  Created by n on 2017/4/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import "LHAlertView.h"

typedef void(^addReviewBlock)(NSString *content,NSNumber *starNum);

@interface HXGradeCommentView : LHAlertView

@property(nonatomic,copy) addReviewBlock addReviewBlock;

@end
