//
//  HXReChargeRecordVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXReChargeRecordVC.h"

#import "HXdealrecordCell.h"
#import "HXConsumptionAPI.h"
#import "HXConsumptionModel.h"
#import "HXWithDrawRecordAPI.h"

@interface HXReChargeRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)   UITableView *dealRecordTable;
@property (nonatomic, strong)   HXConsumptionModel *consumptionModel;

@end

@implementation HXReChargeRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现记录";
    //tableView
    self.dealRecordTable = [[UITableView alloc]initWithFrame:CGRectMake(0,50, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStylePlain];
    self.dealRecordTable.delegate = self;
    self.dealRecordTable.dataSource = self;
    self.dealRecordTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.dealRecordTable];
    [self.dealRecordTable registerNib:[UINib nibWithNibName:@"HXdealrecordCell" bundle:nil] forCellReuseIdentifier:@"HXdealrecordCell"];
    [self getData];
}
- (void)getData{
    
    [[[HXWithDrawRecordAPI getWithDrawRecordData] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        if (error==nil) {
        HXConsumptionModel *api = [HXConsumptionModel new];
        self.consumptionModel = [api.class mj_objectWithKeyValues:responseObject];
        [self.dealRecordTable reloadData];
        }
    }];
}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXdealrecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXdealrecordCell"];
    cell.withDrawmodel = self.consumptionModel.varList[indexPath.row];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.consumptionModel.varList.count;
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
