//
//  HXTeacherGroupArticleVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/14.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXTeacherGroupArticleVC.h"
#import "HXMyArticleCell.h"
#import "HXArticleDetailVC.h"
#import "HXHomeInfoArtcleAPI.h"
#import "HXHomeInfoArticleModel.h"

@interface HXTeacherGroupArticleVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)HXHomeInfoArticleModel *articleModel;

@end

@implementation HXTeacherGroupArticleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"文章列表";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-314) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.view.backgroundColor = kWhiteColor;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    switch (self.detailType) {
        case teacherDetailType:
            [self getTeacherArticleData];
            break;
        case organizationType:
            [self getOrganizationArticleData];
            break;
        default:
            break;
    }
}
//老师文章
- (void)getTeacherArticleData {
   
    [[[HXHomeInfoArtcleAPI getHomeInfoArticleWithTheteacherId:self.teacher_Id mechanism_id:nil limit:@15] netWorkClient]postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        HXHomeInfoArticleModel *api = [HXHomeInfoArticleModel new];

        self.articleModel = [api.class mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];
        
    } ];
    

}
//机构文章
- (void)getOrganizationArticleData{

    [[[HXHomeInfoArtcleAPI getHomeInfoArticleWithTheteacherId:nil mechanism_id:self.mechanism_id limit:@15] netWorkClient]postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        HXHomeInfoArticleModel *api = [HXHomeInfoArticleModel new];
        
        self.articleModel = [api.class mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];

    } ];


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
    
    return 90;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HXMyArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXMyArticleCell"];
    if(!cell){
        
        cell = [HXMyArticleCell initMyArticleCellWithXib];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.articleModel.varList[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HXArticleDetailVC *vc = [HXArticleDetailVC new];
    
    [self.navigationController pushVC:vc];
    
    
}




@end
