//
//  HXCourseDetailTwoVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseDetailTwoVC.h"
#import "HXVideoCatalogueAPI.h"
#import "HXVideoCatalogueModel.h"
#import "HXWatchVideoListAPI.h"
#import "HXAddWatchvideosRecordAPI.h"


@interface HXCourseDetailTwoVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HXVideoCatalogueModel *catalogueModel;
@property (nonatomic, strong) HXVideoCatalogueModel *witchVideoModel;
@property (nonatomic, strong) NSMutableArray *videos_ids;

@end

@implementation HXCourseDetailTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTableView];
    
    [self getVideoCatalogueData];
    
//    [self getWithchVideoRecordData];
}
- (void)getVideoCatalogueData{
    
    [[[HXVideoCatalogueAPI getVideoCatalogueWithWithCurriculum_id:self.curriculum_id] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        HXVideoCatalogueModel *api = [HXVideoCatalogueModel new];
        self.catalogueModel = [api.class mj_objectWithKeyValues:responseObject];
        
        [self getWithchVideoRecordData];
        
       [self.tableView reloadData];
        
    }];
    
}
- (void)getWithchVideoRecordData {

  [[[HXWatchVideoListAPI WatchVideoRecordWithcurriculum_id:self.curriculum_id] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
      
      HXVideoCatalogueModel *api = [HXVideoCatalogueModel new];
      self.witchVideoModel = [api.class mj_objectWithKeyValues:responseObject];
      
      [self.tableView reloadData];
      
  }];
}
- (NSMutableArray *)videos_id {

    if (!_videos_ids) {
        _videos_ids = [NSMutableArray array];
    }
    return _videos_ids;
}
- (void)addTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - WidthScaleSize_H(200)-WidthScaleSize_H(44)-64- WidthScaleSize_H(49)) style:UITableViewStyleGrouped];
    _tableView.separatorColor = [UIColor colorWithWhite:0.8 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    _tableView.rowHeight = 44;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.catalogueModel.varList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    HXCataloguePdModel *model = self.catalogueModel.varList[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"   %@、%@",model.videos_order,model.videos_title];
    
    for (HXCataloguePdModel *model1 in self.witchVideoModel.varList) {
        if ([model.videos_id isEqualToString:model1.videos_id]) {
            cell.textLabel.textColor = APP_COMMON_COLOR;
        }
    }
    cell.textLabel.font = FONT(14);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = APP_COMMON_COLOR;
    HXCataloguePdModel *model = self.catalogueModel.varList[indexPath.row];
    //添加教程观看记录
    [[[HXAddWatchvideosRecordAPI addWatchVideoRecordWithcurriculum_id:self.curriculum_id videos_id:model.videos_id] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
    }];

    self.didselectBlock(model.videos_file);
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = kBlackColor;
    
}
@end
