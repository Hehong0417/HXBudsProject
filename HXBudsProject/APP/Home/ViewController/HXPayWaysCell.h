//
//  HXPayWaysCell.h
//  HXBudsProject
//
//  Created by n on 2017/2/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXPayWaysCell : UITableViewCell

+ (instancetype)initPayWaysCellWithXib;

@property (weak, nonatomic) IBOutlet UIButton *wecatBtn;
@property (weak, nonatomic) IBOutlet UIButton *aliPayBtn;


@end
