//
//  HXPayInformationCell.h
//  HXBudsProject
//
//  Created by n on 2017/2/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXPayInformationCell : UITableViewCell

+ (instancetype)initPayInformationCellWithXib;

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *readPayBtn;

@end
