//
//  HXSearchVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/30.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSearchVC.h"
#import "HXSearchVideoCell.h"
#import "HXSearchArticleCell.h"
#import "HXCourseDetailAnotherVC.h"
#import "HXArticleDetailVC.h"

@interface HXSearchVC ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation HXSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"搜索结果";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return WidthScaleSize_H(38);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        
        return 90;
        
    }else if(indexPath.section == 1){
    
        return 70;
    }
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HXSearchVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXSearchVideoCell"];
        if(!cell){
            
            cell = [HXSearchVideoCell initSearchVideoCellWithXib];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }else {
        HXSearchArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXSearchArticleCell"];
        if(!cell){
            
            cell = [HXSearchArticleCell initSearchArticleCellWithXib];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    return nil;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return @"视频";
    }else{
       return @"文章";
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
        
        [self.navigationController pushVC:vc];
        
    }else {
        HXArticleDetailVC *vc = [HXArticleDetailVC new];
        [self.navigationController pushVC:vc];
    }
    
}



@end
