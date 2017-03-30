//
//  HXSectionHead.h
//  HXBudsProject
//
//  Created by n on 2017/2/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HXSectionHead : UIView

@property(nonatomic,strong)UILabel *headTitleLab;
@property(nonatomic,strong)XYQButton *rightBtn;

- (HXSectionHead *)createSectionHeadWithFrame:(CGRect)frame section:(NSInteger)section headTitle:(NSString *)headtitle discrib:(NSString *)discribText contenType:(ContentType)contentType rightBtnTitle:(NSString *)rightBtnTitle  imageName:(NSString *)imageName labFont:(UIFont *)labFont buttonFontAttributes:(FontAttributes *)btnFontAttributes ;




@end
