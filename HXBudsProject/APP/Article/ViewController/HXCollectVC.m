//
//  HXCollectVC.m
//  HXBudsProject
//
//  Created by n on 2017/4/11.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCollectVC.h"
#import "HXSujectVideoListCell.h"
#import "HXArticleCellTwo.h"
#import "HXArticleDetailVC.h"
#import "HXCourseDetailAnotherVC.h"
#import "UIView+WHC_AutoLayout.h"


@interface HXCollectVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation HXCollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收藏";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-268) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 85;
    }
    CGFloat height = [HXArticleCellTwo whc_CellHeightForIndexPath:indexPath tableView:tableView];
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HXSujectVideoListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HXSujectVideoListCell"];
        if (!cell) {
            
            cell = [HXSujectVideoListCell initSubjectVideoListCellWithXib];
        }
        return cell;
    }else{
    
        HXArticleCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:@"HXArticleCellTwo"];
        if(!cell){
            
            cell = [HXArticleCellTwo initArticleCellTwoWithXib];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.articleType = homeInfoArticle;
         cell.contentLab.text = @"如果您觉得本文非常有用，请随意打赏！鼓励鼓励!如果您觉得本文非常有用，请随意打赏！鼓励鼓励!如果您觉得本文非常有用，请随意打赏！鼓励鼓励!";
        cell.nav = self.navigationController;
        return cell;
    
    }
    
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
        [self.navigationController pushVC:vc];
        
    }else{
        
    HXArticleDetailVC *vc = [HXArticleDetailVC new];
    
    [self.navigationController pushVC:vc];
    
    }
}


@end
