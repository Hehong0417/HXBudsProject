//
//  HXArticleCellTwo.m
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXArticleCellTwo.h"

@implementation HXArticleCellTwo

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.subjectLab lh_setCornerRadius:5 borderWidth:1 borderColor:APP_COMMON_COLOR];
    [self.rightIconImgV lh_setCornerRadius:3 borderWidth:0 borderColor:nil];
    
}
+ (instancetype)initArticleCellTwoWithXib{

    return [[[NSBundle mainBundle]loadNibNamed:@"HXArticleCellTwo" owner:self options:nil] lastObject];

}


@end
