//
//  代码地址: https://github.com/iphone5solo/PYSearch
//  代码地址: http://www.code4app.com/thread-11175-1-1.html
//  Created by CoderKo1o.
//  Copyright © 2016年 iphone5solo. All rights reserved.
//

#import "PYSearchSuggestionViewController.h"
#import "PYSearchConst.h"
#import "HXSearchVideoCell.h"
#import "HXSearchArticleCell.h"
#import "HXCourseDetailAnotherVC.h"
#import "HXArticleDetailVC.h"

@interface PYSearchSuggestionViewController ()

@property(nonatomic,strong)UITableView *tabView;

@end

@implementation PYSearchSuggestionViewController


+ (instancetype)searchSuggestionViewControllerWithDidSelectCellBlock:(PYSearchSuggestionDidSelectCellBlock)didSelectCellBlock
{
    PYSearchSuggestionViewController *searchSuggestionVC = [[PYSearchSuggestionViewController alloc] init];
    searchSuggestionVC.didSelectCellBlock = didSelectCellBlock;
    return searchSuggestionVC;
}
- (void)loadView {

    self.view = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) backColor:kClearColor];
    self.tabView = [UITableView lh_tableViewWithFrame:CGRectMake(0,-64, SCREEN_WIDTH, SCREEN_HEIGHT+64) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
    [self.view addSubview:self.tabView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 取消分割线
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setSearchSuggestions:(NSArray *)searchSuggestions
{
    _searchSuggestions = [searchSuggestions copy];
    
    // 刷新数据
    [self.tabView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInSearchSuggestionView:)]) {
        return [self.dataSource numberOfSectionsInSearchSuggestionView:tableView];
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(searchSuggestionView:numberOfRowsInSection:)]) {
        return [self.dataSource searchSuggestionView:tableView numberOfRowsInSection:section];
    }
    NSArray *arr = self.searchSuggestions[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if ([self.dataSource respondsToSelector:@selector(searchSuggestionView:cellForRowAtIndexPath:)]) {
////        UITableViewCell *cell= [self.dataSource searchSuggestionView:tableView cellForRowAtIndexPath:indexPath];
//        if (indexPath.section == 0) {
//            
//             HXSearchVideoCell *cell= (HXSearchVideoCell *)[self.dataSource searchSuggestionView:tableView cellForRowAtIndexPath:indexPath];
//            
//            return cell;
//        }else {
//               HXSearchArticleCell *cell= (HXSearchArticleCell*)[self.dataSource searchSuggestionView:tableView cellForRowAtIndexPath:indexPath];
//            
//            return cell;
//        }
//        return nil;
//    }
    
    //***********************//
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
    //**************************//
    
    
    
//    // 使用默认的搜索建议Cell
//    static NSString *cellID = @"PYSearchSuggestionCellID";
//    // 创建cell
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        cell.textLabel.textColor = [UIColor darkGrayColor];
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        cell.backgroundColor = [UIColor clearColor];
//        // 添加分割线
//        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PYSearch.bundle/cell-content-line"]];
//        line.py_height = 0.5;
//        line.alpha = 0.7;
//        line.py_x = PYMargin;
//        line.py_y = 43;
//        line.py_width = PYScreenW;
//        [cell.contentView addSubview:line];
//    }
    // 设置数据
//    cell.imageView.image = PYSearchSuggestionImage;
//    cell.textLabel.text = self.searchSuggestions[indexPath.row];
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ([self.dataSource respondsToSelector:@selector(searchSuggestionView:heightForRowAtIndexPath:)]) {
            return [self.dataSource searchSuggestionView:tableView heightForRowAtIndexPath:indexPath];
        }
        return 90;
        
    }else{
        if ([self.dataSource respondsToSelector:@selector(searchSuggestionView:heightForRowAtIndexPath:)]) {
            return [self.dataSource searchSuggestionView:tableView heightForRowAtIndexPath:indexPath];
        }

        return 70;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return @"视频";
    }else {
    
       return @"文章";
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectCellBlock) self.didSelectCellBlock([tableView cellForRowAtIndexPath:indexPath]);

    if (indexPath.section == 0) {
        [self.navigationController pushVC:[HXCourseDetailAnotherVC new]];
        
    }else{
    
        [self.navigationController pushVC:[HXArticleDetailVC new]];
    }
    
}

@end
