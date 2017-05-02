//
//  HXSubjectListTVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSubjectListTVC.h"
#import "HXArticleCellTwo.h"
#import "HXArticleDetailVC.h"

@interface HXSubjectListTVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation HXSubjectListTVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.title = self.titleStr;

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 135;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HXArticleCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:@"HXArticleCellTwo"];
    if(!cell){
        
        cell = [HXArticleCellTwo initArticleCellTwoWithXib];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HXArticleDetailVC *vc = [HXArticleDetailVC new];
    
    [self.navigationController pushVC:vc];

    
}


@end
