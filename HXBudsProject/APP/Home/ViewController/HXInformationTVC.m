//
//  HXInformationTVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXInformationTVC.h"
#import "HXInformationCell.h"
#import "HXInformationDetailVC.h"


@interface HXInformationTVC ()

@end

@implementation HXInformationTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"资讯";
    
    if (self.isMyLike) {
        
        UIView *view = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(44)) backColor:kWhiteColor];
        self.tableView.tableHeaderView = view;
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return WidthScaleSize_H(103);

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HXInformationCell   *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    
    if (!cell) {
        
        cell = [HXInformationCell initInformationCellWithXib];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    HXInformationDetailVC *vc = [HXInformationDetailVC new];
    [self.navigationController pushVC:vc];
   

}

@end
