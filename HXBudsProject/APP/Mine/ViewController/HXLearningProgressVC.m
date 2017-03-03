//
//  HXLearningProgressVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXLearningProgressVC.h"

@interface HXLearningProgressVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tabView;

@end

@implementation HXLearningProgressVC

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


}
- (void)counponAction:(UIButton *)btn{
    
    if (btn.tag == 1) {
        //正在学习
    }
    if (btn.tag == 2) {
        //学习历程
        
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
