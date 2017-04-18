//
//  HXMyVideoVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyVideoVC.h"
#import "HXSujectVideoListCell.h"
#import "HXCourseDetailAnotherVC.h"

@interface HXMyVideoVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation HXMyVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的视频";
    switch (self.videoType) {
        case myVideo:{
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        }
            break;
        default:{
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-268) style:UITableViewStyleGrouped];
        }
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
    
    return 4;
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
    
    HXCourseDetailAnotherVC  *vc = [HXCourseDetailAnotherVC new];
    [self.navigationController pushVC:vc];
    
    
}


@end
