//
//  HXMyArticleVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyArticleVC.h"
#import "HXMyArticleCell.h"
#import "HXArticleDetailVC.h"
#import "HXHomeInfoArtcleAPI.h"
#import "HXHomeInfoArticleModel.h"

@interface HXMyArticleVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;


@end

@implementation HXMyArticleVC

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //文章
    [self getArticleData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的文章";
    
    switch (self.articleType) {
        case mineArticle:
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
            break;
        case mineDynamicArticle:
           self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 268) style:UITableViewStyleGrouped];
            break;
        case teacherDynamicArticle:
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 268) style:UITableViewStyleGrouped];
            break;
        case himDynamicArticle:
          self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 268) style:UITableViewStyleGrouped];
            break;
        default:
            
            break;
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.showsVerticalScrollIndicator = NO;

    NSLog(@"infoArticleListModel---%@",self.infoArticleListModel);
}
- (void)getArticleData{
    
    [[[HXHomeInfoArtcleAPI getHomeInfoArticleWithTheteacherId:self.theteacher_id mechanism_id:nil limit:@10] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        NSLog(@"responseObject--%@",responseObject);
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
