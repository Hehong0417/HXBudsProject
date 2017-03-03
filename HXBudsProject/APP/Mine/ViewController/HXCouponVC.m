//
//  HXCouponVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCouponVC.h"

@interface HXCouponVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tabView;
@end

@implementation HXCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
  

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *view = [UIView lh_viewWithFrame:CGRectMake(0, 0, 180, 30) backColor:kClearColor];
    UIImageView *couponImageV = [UIImageView lh_imageViewWithFrame:view.bounds image:[UIImage imageNamed:@"segment"]];
    [view addSubview:couponImageV];
    
    NSArray *titleColors= @[APP_COMMON_COLOR,kWhiteColor];
    NSArray *titles  = @[@"可用优惠券",@"历史优惠券"];
    
    for (NSInteger i=0; i<2; i++) {
        
        UIButton *btn = [UIButton lh_buttonWithFrame:CGRectMake(1+i*85, 1, 85, 30) target:self action:@selector(counponAction:) title:titles[i] titleColor:titleColors[i] font:FONT(14) backgroundColor:kClearColor];
        btn.tag = i + 1;
        [view addSubview:btn];
    }
    self.navigationItem.titleView = view;
    
    //兑换框
    UITextField *convert_box = [UITextField lh_textFieldWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 38) placeholder:@"输入活动优惠码" font:FONT(14) textAlignment:NSTextAlignmentLeft backgroundColor:nil];
    [convert_box setBackground:[UIImage imageNamed:@"convert_box"]];
    convert_box.leftViewMode = UITextFieldViewModeAlways;
    convert_box.rightViewMode = UITextFieldViewModeAlways;
    UIImageView *imgV =  [UIImageView lh_imageViewWithFrame:CGRectMake(0, 0, 35, 38) image:[UIImage imageNamed:@"discount"]];
    imgV.contentMode = UIViewContentModeCenter;
    convert_box.leftView = imgV;
    [self.view addSubview:convert_box];
    UILabel *convertLab = [UILabel lh_labelWithFrame:CGRectMake(0, 0, 38, 38) text:@"兑换" textColor:kLightGrayColor font:FONT(14) textAlignment:NSTextAlignmentCenter backgroundColor:kClearColor];
    convert_box.rightView = convertLab;
    UIView *leftLine = [UIView lh_viewWithFrame:CGRectMake(0, 0, 1, 38) backColor:kLightGrayColor];
    [convertLab addSubview:leftLine];
    
    
//    //tabView
    self.tabView = [UITableView lh_tableViewWithFrame:CGRectMake(0, 62, SCREEN_WIDTH, SCREEN_HEIGHT - 62) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];

}
- (void)counponAction:(UIButton *)btn{

    if (btn.tag == 1) {
        //可用优惠券
    }
    if (btn.tag == 2) {
        //历史优惠券
        
    }

}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}



@end
