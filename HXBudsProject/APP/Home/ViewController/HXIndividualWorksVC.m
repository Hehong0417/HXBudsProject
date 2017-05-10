//
//  HXIndividualWorksVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXIndividualWorksVC.h"
#import "HXInstrumentCell.h"
#import "HXOpusDetailVC.h"

@interface HXIndividualWorksVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)   UITableView *IndividualWorkListTable;

@end

@implementation HXIndividualWorksVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人作品";
    //tableView
    self.IndividualWorkListTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStylePlain];
    self.IndividualWorkListTable.delegate = self;
    self.IndividualWorkListTable.dataSource = self;
    self.IndividualWorkListTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.IndividualWorkListTable];
    
}

#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXInstrumentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXInstrumentCell"];
    if(!cell){
        
        cell = [HXInstrumentCell initInstrumentCellWithXib];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXOpusDetailVC *vc = [[HXOpusDetailVC alloc]init];
    [self.navigationController pushVC:vc];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}


@end
