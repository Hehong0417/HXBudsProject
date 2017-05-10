//
//  HXAccountReChargeVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXAccountReChargeVC.h"
#import "HXAccountReChargeCell.h"
@interface HXAccountReChargeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)   UITableView *accountReChargeTable;
@property (nonatomic, strong)   NSString *money;

@end

@implementation HXAccountReChargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户充值";
    //tableView
    self.accountReChargeTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStylePlain];
    self.accountReChargeTable.delegate = self;
    self.accountReChargeTable.dataSource = self;
    self.accountReChargeTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.accountReChargeTable];
    [self.accountReChargeTable registerClass:[HXAccountReChargeCell class] forCellReuseIdentifier:@"HXAccountReChargeCell"];
    
    //马上充值
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) backColor:kWhiteColor];
    
    UIButton *reChargeBtn = [UIButton lh_buttonWithFrame:CGRectMake(35, 27, SCREEN_WIDTH - 70, 35) target:self action:@selector(reChargeAction) title:@"马上充值" titleColor:kWhiteColor font:FONT(16) backgroundColor:APP_COMMON_COLOR];
    [reChargeBtn lh_setCornerRadius:3 borderWidth:0 borderColor:nil];
    [footView addSubview:reChargeBtn];
    self.accountReChargeTable.tableFooterView = footView;
}

#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = @"微信支付";
        return cell;
    }else {
        
        HXAccountReChargeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXAccountReChargeCell"];
        cell.tabControl.selectTabControlBlock = ^(NSString *money) {
            NSLog(@"money-%@",money);
            self.money = money;
        };
        return cell;
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 50;
    }else{
        
     return 160;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    HXOpusDetailVC *vc = [[HXOpusDetailVC alloc]init];
    //    [self.navigationController pushVC:vc];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (void)reChargeAction {

    
    NSLog(@"self.money-%@",self.money);


}

@end
