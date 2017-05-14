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
#import "HXSubjectArticleAPI.h"
#import "HXHomeInfoArticleModel.h"

@interface HXSubjectListTVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)HXHomeInfoArticleModel *articleModel;

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

    [self getSubjectArticleData];
    
}
- (void)getSubjectArticleData {

   [[[HXSubjectArticleAPI getSubjectArticleWithArticletype_id:self.articletype_id] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
       
       HXHomeInfoArticleModel *api = [HXHomeInfoArticleModel new];
       
       self.articleModel = [api.class mj_objectWithKeyValues:responseObject];
       [self.tableView reloadData];
       
   }];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.articleModel.varList.count;
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
    HXInfoArticleListModel *model = self.articleModel.varList[indexPath.row];
    cell.model = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXArticleDetailVC *vc = [HXArticleDetailVC new];
    HXInfoArticleListModel *model = self.articleModel.varList[indexPath.row];
    vc.articleModel = model;
    [self.navigationController pushVC:vc];

    
}


@end
