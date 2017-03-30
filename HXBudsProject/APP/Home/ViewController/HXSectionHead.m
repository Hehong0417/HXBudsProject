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
    
    
    CGSize nameSize = [headtitle lh_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH, 30)];
    //标题
    UILabel *headTitleLab = [UILabel lh_labelWithFrame:CGRectMake(10, 4, nameSize.width, frame.size.height-4) text:headtitle textColor:kBlackColor font:labFont textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    [head addSubview:headTitleLab];
    
    //描述
    UILabel *discribLab = [UILabel lh_labelWithFrame:CGRectMake(CGRectGetMaxX(headTitleLab.frame)+10, 4, 200, frame.size.height-4) text:discribText textColor:[UIColor colorWithHexString:@"#BABABA"] font:FONT(12) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    [head addSubview:discribLab];
    
    XYQButton *changeBtn = [XYQButton ButtonWithFrame:CGRectMake(SCREEN_WIDTH - WidthScaleSize_W(80), 2, WidthScaleSize_W(80), frame.size.height-2) imgaeName:imageName titleName:rightBtnTitle contentType:contentType buttonFontAttributes:btnFontAttributes tapAction:^(XYQButton *button) {
        
    }];
    changeBtn.enabled = NO;
    [head addSubview:changeBtn];
    
    
    return head;

}
- (void)testAction{


}
@end
