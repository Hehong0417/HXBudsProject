//
//  HXSubjectVideoVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXSubjectVideoVC.h"
#import "HXSujectVideoListCell.h"
#import "HXCourseDetailAnotherVC.h"


@interface HXSubjectVideoVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation HXSubjectVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title = @"专题视频";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HXSujectVideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXSujectVideoListCell"];
    if(!cell){
        
        cell = [HXSujectVideoListCell initSubjectVideoListCellWithXib];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
    [self.navigationController pushVC:vc];
    
}




@end
