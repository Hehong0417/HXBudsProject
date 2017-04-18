//
//  HXMyAttetionVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyAttetionVC.h"
#import "HXMyAttentionCell.h"
#import "HXMyLikeVC.h"

@interface HXMyAttetionVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;


@end

@implementation HXMyAttetionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我关注的";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-268) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = kWhiteColor;

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
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
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXMyLikeVC *vc = [HXMyLikeVC new];
    vc.titleStr = @"他的网页";
    [self.navigationController pushViewController:vc animated:YES];
    
}




@end
