//
//  HXVideoSectionHead.h
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HXSectionHeadDalegate <NSObject>

- (void)rightBtnActionWithSection:(NSInteger)section;

@end

@interface HXVideoSectionHead : UICollectionReusableView


@property(nonatomic,copy)NSString *headtitle;
@property(nonatomic,copy)NSString *discribText;
@property(nonatomic,copy)NSString *rightBtnTitle;
@property(nonatomic,assign)ContentType contentType;
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,assign)NSInteger labFont;
@property(nonatomic,strong) FontAttributes *btnFontAttributes;
@property(nonatomic,strong)UILabel *headTitleLab;
@property(nonatomic,strong)XYQButton *rightBtn;
@property(nonatomic,weak) id<HXSectionHeadDalegate>delegate;



@end
