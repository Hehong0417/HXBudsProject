//
//  HXSectionHead.m
//  HXBudsProject
//
//  Created by n on 2017/2/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSectionHead.h"

@implementation HXSectionHead


- (HXSectionHead *)createSectionHeadWithFrame:(CGRect)frame section:(NSInteger)section headTitle:(NSString *)headtitle contenType:(ContentType)contentType rightBtnTitle:(NSString *)rightBtnTitle imageName:(NSString *)imageName labFont:(UIFont *)labFont buttonFontAttributes:(FontAttributes *)btnFontAttributes {

    HXSectionHead *head = [[HXSectionHead alloc]initWithFrame:frame];
    head.backgroundColor = KVCBackGroundColor;
    UILabel *headTitleLab = [UILabel lh_labelWithFrame:CGRectMake(0, 4, 200, frame.size.height-4) text:headtitle textColor:kBlackColor font:labFont textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    [head addSubview:headTitleLab];
    
    XYQButton *changeBtn = [XYQButton ButtonWithFrame:CGRectMake(SCREEN_WIDTH - WidthScaleSize_W(80), 2, WidthScaleSize_W(80), frame.size.height-2) imgaeName:imageName titleName:rightBtnTitle contentType:contentType buttonFontAttributes:btnFontAttributes tapAction:^(XYQButton *button) {
        
        if ([head.delegate respondsToSelector:@selector(rightBtnActionWithSection:)]) {
            
            [head.delegate rightBtnActionWithSection:section];
        }
      
    }];
    
    [head addSubview:changeBtn];
    
    
    return head;

}

@end
