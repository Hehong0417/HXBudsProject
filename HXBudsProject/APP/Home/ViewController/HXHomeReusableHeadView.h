//
//  HXHomeReusableHeadView.h
//  HXBudsProject
//
//  Created by n on 2017/4/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"



@interface HXHomeReusableHeadView : UICollectionReusableView


@property (nonatomic, strong)  SDCycleScrollView *cycleSrollView;

@property(nonatomic,copy)NSString *headtitle;
@property(nonatomic,copy)NSString *discribText;
@property(nonatomic,copy)NSString *rightBtnTitle;
@property(nonatomic,assign)ContentType contentType;
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,assign)NSInteger labFont;
@property(nonatomic,strong) FontAttributes *btnFontAttributes;
@property(nonatomic,strong)UILabel *headTitleLab;
@property(nonatomic,strong)XYQButton *rightBtn;
@property(nonatomic,strong)NSArray *imageURLStringsGroup;


@end
