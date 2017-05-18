//
//  HXBrowserRecordVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXBrowserRecordArticleVC.h"
#import "HXMyArticleCell.h"
#import "HXArticleDetailVC.h"
#import "HXBroserRecordArticleAPI.h"
#import "HXMyCollectArticleAPI.h"

@interface HXBrowserRecordArticleVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong) HXHomeInfoArticleModel *infoArticleListModel;

@end

@implementation HXBrowserRecordArticleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getBroserRcordArticleData];
    
    
    self.title = @"浏览记录";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    [self.view addSubview:self.tableView];
    
    
    
}

- (void)getBroserRcordArticleData{

 [[[HXMyCollectArticleAPI getMycollectionarticle] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
     HXHomeInfoArticleModel *api = [HXHomeInfoArticleModel new];
     
     self.infoArticleListModel = [api.class mj_objectWithKeyValues:responseObject];
     
     [self.tableView reloadData];

 }];
  
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.infoArticleListModel.varList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HXMyArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXMyArticleCell"];
    if(!cell){
        
        cell = [HXMyArticleCell initMyArticleCellWithXib];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    HXInfoArticleListModel *InfoArticleModel = self.infoArticleListModel.varList[indexPath.row];
    cell.model = InfoArticleModel;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXArticleDetailVC *vc = [HXArticleDetailVC new];
    [self.navigationController pushVC:vc];
    
    
}





@end
