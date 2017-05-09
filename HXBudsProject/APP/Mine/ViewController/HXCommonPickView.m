//
//  HXCommonPickView.m
//  HXBudsProject
//
//  Created by n on 2017/3/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCommonPickView.h"

@interface HXCommonPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong) NSArray *titleArr;

@end

@implementation HXCommonPickView

- (instancetype)initWithFrame:(CGRect)frame {


    if (self == [super initWithFrame:frame]) {
        
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 180)];
        contentView.backgroundColor = kWhiteColor;
        self.contentView = contentView;
        
        UIView *finishView = [UIView lh_viewWithFrame:CGRectMake(-2, 0, SCREEN_WIDTH+4, 30) backColor:kWhiteColor];
        [contentView addSubview:finishView];
        [finishView lh_setCornerRadius:0 borderWidth:1 borderColor:LineLightColor];
        UIButton *finishBtn = [UIButton lh_buttonWithFrame:CGRectMake(SCREEN_WIDTH-60, 0, 60, 30) target:self action:@selector(finished:) title:@"完成" titleColor:APP_COMMON_COLOR font:FONT(18) backgroundColor:kWhiteColor];
        [finishView addSubview:finishBtn];
        
        
        [self addSubview:contentView];
    }
    
    return self;
}

- (void)finished:(UIButton *)btn {

    [self hidePickViewComplete:nil];
  
    if (self.style == HXCommonPickViewStyleSex) {
        
        self.completeBlock(self.selectedSexItem);

    }else{
     
//        NSString *selectedItem = [NSString stringWithFormat:@"%ld",[NSDate getAgeFromBirthDay:self.datePick.date]];
        NSString *selectedItem = [self.datePick.date lh_string_yyyyMMdd];

        NSLog(@"selectedItem:%@",selectedItem);
        
        self.completeBlock(selectedItem);
    
    }
}
- (void)setStyle:(HXCommonPickViewStyle)style {

    _style = style;
    
            if (self.style == HXCommonPickViewStyleSex) {
    
                UIPickerView *sexPick = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 150)];
                sexPick.dataSource = self;
                sexPick.delegate = self;
                [self pickerView:sexPick didSelectRow:0 inComponent:0];
                [self.contentView addSubview:sexPick];
    
            }else if (self.style == HXCommonPickViewStyleDate){
    
                UIDatePicker *datePick = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, 150)];
                datePick.datePickerMode = UIDatePickerModeDate;
                datePick.locale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"];
                datePick.minimumDate = [NSDate dateWithTimeIntervalSince1970:0];
                datePick.maximumDate = [NSDate date];
                self.datePick = datePick;
                NSLog(@"date:%@",datePick.date);
                [self.contentView addSubview:datePick];
       
            }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 44;

}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 2;
   
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.selectedSexItem = self.titleArr[row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {

    UILabel *titleLabel = [UILabel lh_labelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH+4, 44) text:self.titleArr[row] textColor:kBlackColor font:FONT(18) textAlignment:NSTextAlignmentCenter backgroundColor:kWhiteColor];
    return titleLabel;

}


- (NSArray *)titleArr {

    if (!_titleArr) {
        _titleArr = @[@"男",@"女"];
    }
    return _titleArr;
}
- (void)showPickViewAnimation:(BOOL)animated{

    self.animated = animated;
    [self addsuperView];
    if (animated) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.contentView.lh_top = self.lh_bottom - 180;
            
        } completion:^(BOOL finished) {
            
            
        }];
    }
   
 
}
- (void)addsuperView{

    [kKeyWindow addSubview:self];


}
- (void)hidePickViewComplete:(void (^)())completeBlock {

    if (self.animated) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.contentView.lh_top = self.lh_bottom;

        } completion:^(BOOL finished) {
            
            [self removePickView];
        }];
    }


}

- (void)removePickView {

    [self removeFromSuperview];

}
@end
