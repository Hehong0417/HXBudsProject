//
//  HXMyArticleCell.h
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXHomeInfoArticleModel.h"

@interface HXMyArticleCell : UITableViewCell

@property(nonatomic,strong) HXInfoArticleListModel *model;

+ (instancetype)initMyArticleCellWithXib;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *readLab;

@property (weak, nonatomic) IBOutlet UILabel *tapLab;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property (weak, nonatomic) IBOutlet UIImageView *rightIcon;

@end
