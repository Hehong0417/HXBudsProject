//
//  HXDealRecordVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXDealRecordVC.h"
#import "HXdealrecordCell.h"


@interface HXDealRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)   UITableView *dealRecordTable;

@end

@implementation HXDealRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"交易记录";
    //tableView
    self.dealRecordTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStylePlain];
    self.dealRecordTable.delegate = self;
    self.dealRecordTable.dataSource = self;
    self.dealRecordTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.dealRecordTable];
    [self.dealRecordTable registerNib:[UINib nibWithNibName:@"HXdealrecordCell" bundle:nil] forCellReuseIdentifier:@"HXdealrecordCell"];
}

#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXdealrecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXdealrecordCell"];
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
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


@end
