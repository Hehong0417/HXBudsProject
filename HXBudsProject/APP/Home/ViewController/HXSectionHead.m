//
//  HXSectionHead.m
//  HXBudsProject
//
//  Created by n on 2017/2/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSectionHead.h"



@implementation HXSectionHead


- (HXSectionHead *)createSectionHeadWithFrame:(CGRect)frame section:(NSInteger)section headTitle:(NSString *)headtitle discrib:(NSString *)discribText contenType:(ContentType)contentType rightBtnTitle:(NSString *)rightBtnTitle imageName:(NSString *)imageName labFont:(UIFont *)labFont buttonFontAttributes:(FontAttributes *)btnFontAttributes {

    HXSectionHead *head = [[HXSectionHead alloc]initWithFrame:frame];
//    head.backgroundColor = KVCBackGroundColor;
    
    //分类图片
    UIImageView *categoryImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, frame.size.height)];
    categoryImageV.image = [UIImage imageNamed:@"category"];
    categoryImageV.contentMode = UIViewContentModeLeft;
//    categoryImageV.backgroundColor = kOrangeColor;
    [head addSubview:categoryImageV];
    
    
    CGSize nameSize = [headtitle lh_sizeWithFont:FONT(14) constrainedToSize:CGSizeMake(SCREEN_WIDTH, 30)];
    //标题
    UILabel *headTitleLab = [UILabel lh_labelWithFrame:CGRectMake(10, 0, nameSize.width, frame.size.height) text:headtitle textColor:kBlackColor font:labFont textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    [head addSubview:headTitleLab];
    
    //描述
    UILabel *discribLab = [UILabel lh_labelWithFrame:CGRectMake(CGRectGetMaxX(headTitleLab.frame)+10, 0, 200, frame.size.height) text:discribText textColor:RGB(186, 186, 186) font:FONT(12) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    [head addSubview:discribLab];
    
    XYQButton *changeBtn = [XYQButton ButtonWithFrame:CGRectMake(SCREEN_WIDTH - WidthScaleSize_W(80), 0, WidthScaleSize_W(80), frame.size.height) imgaeName:imageName titleName:rightBtnTitle contentType:contentType buttonFontAttributes:btnFontAttributes tapAction:^(XYQButton *button) {
        
    }];
    changeBtn.enabled = NO;
    [head addSubview:changeBtn];
    
    
    return head;

}
- (void)testAction{


}
@end
