//
//  HXCurriculumTypeCell.m
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCurriculumTypeCell.h"
#import "HXInstrumentVC.h"
#import "HXTeachingTypeListAPI.h"
#import "HXTeachingTypeListModel.h"

@interface HXCurriculumTypeCell ()

@property (nonatomic, strong) HXTeachingTypeListModel *teachingTypeListModel;

@end

@implementation HXCurriculumTypeCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        //列数
        NSInteger lineCount = 4;
        NSArray *titleArr = @[@"西洋乐器",@"民族乐器",@"舞蹈",@"书法",@"绘画",@"声乐",@"武术",@"语言艺术"];
        NSArray *imageArr = @[@"xiyangyueqi",@"minzuyueqi",@"wudao",@"shufa",@"huihua",@"shengyue",@"wushu",@"yuyanyish"];
        
        [self getTeachingTypeDataCompleteHandle:^(HXTeachingTypeListModel *model) {
            for (NSInteger i = 0; i< 8; i++) {
                NSInteger line = i % lineCount;
                NSInteger row = i / lineCount;
                CGFloat btn_W = WidthScaleSize_H(70);
                CGFloat btn_H = WidthScaleSize_H(80);
                //列间距
                CGFloat lineMargin = (SCREEN_WIDTH - 20 - lineCount *btn_W) / 8;
                //行间距
                CGFloat rowMargin = lineMargin;
                
                CGFloat btn_x = lineMargin + (lineMargin*2 + btn_W)*line;
                
                CGFloat btn_y = (rowMargin + btn_H)*row;
                
                XYQButton *curriTypeBtn = [XYQButton ButtonWithFrame:CGRectMake(btn_x, btn_y, btn_W, btn_H)  imgaeName:imageArr[i] titleName:titleArr[i] contentType:TopImageBottomTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kDarkGrayColor fontsize:14] tapAction:^(XYQButton *button) {
                    
                    HXInstrumentVC *vc = [HXInstrumentVC new];
                    HXTeachingTypeVarListModel *model1 = model.varList[i];
                    vc.teachingtype_id = model1.teachingtype_id;
                    vc.type_name = model1.type_name;
                    [self.nav pushVC:vc];
                    
                }];
                //            curriTypeBtn.backgroundColor = APP_COMMON_COLOR;
                [self addSubview:curriTypeBtn];
            }

        }];
       
    }
    
    return self;
}

- (void)getTeachingTypeDataCompleteHandle:(void(^)(HXTeachingTypeListModel *model))completeHandle{

    
        [[[HXTeachingTypeListAPI getTeachingTypeList] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
            if (error==nil) {
            HXTeachingTypeListModel *api = [HXTeachingTypeListModel new];
            self.teachingTypeListModel = [api.class mj_objectWithKeyValues:responseObject];
            completeHandle(self.teachingTypeListModel);
            }
        }];

}
@end
