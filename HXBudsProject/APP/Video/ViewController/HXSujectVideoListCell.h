//
//  HXInformationCell.h
//  HXBudsProject
//
//  Created by n on 2017/2/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXSubjectVideoListModel.h"


@interface HXSujectVideoListCell : UITableViewCell

+ (instancetype)initSubjectVideoListCellWithXib;

@property (strong, nonatomic)  HXSubjectVideoModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *curr_picture;
@property (weak, nonatomic) IBOutlet UILabel *curr_title;
@property (weak, nonatomic) IBOutlet UILabel *when_long;
@property (weak, nonatomic) IBOutlet UILabel *read;

@end
