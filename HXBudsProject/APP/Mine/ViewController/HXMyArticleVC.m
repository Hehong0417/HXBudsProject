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

@interface HXMyArticleVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;


@end

@implementation HXMyArticleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的文章";
    switch (self.articleType) {
        case myArticle:
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
            break;
            
        default:
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 268) style:UITableViewStyleGrouped];
            break;
    }
    
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
    
    return 6;
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
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXArticleDetailVC *vc = [HXArticleDetailVC new];
    [self.navigationController pushVC:vc];
    
    
}




@end
