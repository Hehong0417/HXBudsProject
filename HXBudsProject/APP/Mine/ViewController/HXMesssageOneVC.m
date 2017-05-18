//
//  HXCourseOneVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMesssageOneVC.h"
#import "HXMessageCell.h"
#import "HXMyMessageAPI.h"
#import "HXMyMessageModel.h"

@interface HXMesssageOneVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tabView;
@property(nonatomic,strong)HXMyMessageModel *myMessageModel;

@end

@implementation HXMesssageOneVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的消息";
    self.tabView = [UITableView lh_tableViewWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabView];
    self.tabView.showsVerticalScrollIndicator = NO;
    self.tabView.backgroundColor = kWhiteColor;
    [self getMyMessageData];
    
    
}
- (void)getMyMessageData {

   [[[HXMyMessageAPI getMyMessage] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
       
       HXMyMessageModel *api = [HXMyMessageModel new];
       self.myMessageModel = [api.class mj_objectWithKeyValues:responseObject];
       [self.tabView reloadData];
   }];
}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        HXMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXMessageCell"];
        if(!cell){
            
            cell = [HXMessageCell initMessageCellWithXib];
        }
        cell.model = self.myMessageModel.varList[indexPath.row];
    
        return cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

        return self.myMessageModel.varList.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        return 80;

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

@end
