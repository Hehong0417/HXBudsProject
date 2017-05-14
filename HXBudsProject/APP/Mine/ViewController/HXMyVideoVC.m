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
#import "HXSubjectVideoAPI.h"
#import "HXSubjectVideoListModel.h"
@interface HXMyVideoVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation HXMyVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //视频
    [self getVideoData];
    
    self.title = @"我的视频";
    switch (self.videoType) {
        case mineVideo:{
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        }
            break;
        case teacherVideo:{
          self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-268) style:UITableViewStyleGrouped];
        }
            break;
        default:
            break;
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.showsVerticalScrollIndicator = NO;

}
- (void)getVideoData{
    
    [[[HXSubjectVideoAPI getSubjectVideoWithLimit:@5 theteacherId:nil curriculum­­_status:nil isLogin:YES] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        
        HXSubjectVideoListModel *api = [HXSubjectVideoListModel new];
        
        self.SubjectVideoListModel = [api.class mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.SubjectVideoListModel.varList.count;
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
    HXSubjectVideoModel *model = self.SubjectVideoListModel.varList[indexPath.row];
    cell.model = model;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXCourseDetailAnotherVC  *vc = [HXCourseDetailAnotherVC new];
    HXSubjectVideoModel *model = self.SubjectVideoListModel.varList[indexPath.row];
    vc.curriculum_id = model.curriculum_id;
    vc.playImageStr = model.curr_picture;
    vc.curriculum_price = model.curriculum_price;
    vc.charge_status_text = model.charge_status_text;
    [self.navigationController pushVC:vc];
    
    
}


@end
