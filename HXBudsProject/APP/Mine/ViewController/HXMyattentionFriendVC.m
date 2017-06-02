//
//  HXMyattentionFriendVC.m
//  HXBudsProject
//
//  Created by n on 2017/4/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyattentionFriendVC.h"
#import "HXMyAttentionCell.h"
#import "HXMyLikeVC.h"
#import "HXMyAttentionFrendsAPI.h"
#import "HXAttentionFriendModel.h"


@interface HXMyattentionFriendVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)HXAttentionFriendModel *attentionFriendModel;


@end

@implementation HXMyattentionFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];

   self.title = @"机构";
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = kWhiteColor;

    [[[HXMyAttentionFrendsAPI getMyAttentionFrends] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        if (error==nil) {
        HXAttentionFriendModel *api = [HXAttentionFriendModel new];
        self.attentionFriendModel = [api.class mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];
        }
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.attentionFriendModel.varList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 104;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXMyAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXMyAttentionCell"];
    if(!cell){
        
        cell = [HXMyAttentionCell initMyAttentionCellWithXib];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.friendsModel = self.attentionFriendModel.varList[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    HXMyLikeVC *vc = [HXMyLikeVC new];
//    vc.titleStr = @"他的网页";
//    vc.dynamicType = himDynamicType;
//    [self.navigationController pushViewController:vc animated:YES];
    
}





@end
