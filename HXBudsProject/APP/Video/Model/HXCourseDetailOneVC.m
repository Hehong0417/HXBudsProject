//
//  SegmentViewController.m
//  SegmentPage
//
//  Created by 小李 on 16/9/2.
//  Copyright © 2016年 小李. All rights reserved.
//

#import "HXCourseDetailOneVC.h"
#import "HXCourseDetailCourseTitleCell.h"
#import "HXCourseDetailIntroduceCell.h"
#import "HXCurriculumDetailAPI.h"
#import "HXCurrilumDetailModel.h"
#import "HXVideoCatalogueAPI.h"
#import "HXVideoCatalogueModel.h"

@interface HXCourseDetailOneVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HXCurrilumDetailModel *curriculumDetailModel;
@property (nonatomic, strong) HXVideoCatalogueModel *catalogueModel;


@end

@implementation HXCourseDetailOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    // Do any additional setup after loading the view.
    
    [self getCurriculumDetailData];
    [self getVideoCatalogueData];
}
- (void)getVideoCatalogueData{
    
    [[[HXVideoCatalogueAPI getVideoCatalogueWithWithCurriculum_id:self.curriculum_id] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        if (error==nil) {
        HXVideoCatalogueModel *api = [HXVideoCatalogueModel new];
        self.catalogueModel = [api.class mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];
        }
    }];
    
}
- (void)getCurriculumDetailData{

    [[[HXCurriculumDetailAPI getCurriculumDetailWithWithCurriculum_id:self.curriculum_id] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        if (error==nil) {
        HXCurrilumDetailModel *model = [HXCurrilumDetailModel new];
        self.curriculumDetailModel = [model.class mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];
        }
    }];


}
- (void)addTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-WidthScaleSize_H(200)-WidthScaleSize_H(44)-64 - WidthScaleSize_H(49)) style:UITableViewStyleGrouped];
    _tableView.separatorColor = [UIColor colorWithWhite:0.8 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    _tableView.rowHeight = 44;
    _tableView.backgroundColor = kWhiteColor;
    [self.view addSubview:_tableView];
    NSLog(@"countcountcountcount%@",self.count);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        
        return 124;
        
    }else if(indexPath.row ==1){
    
        return 110;
        
    }else {
    
        return  110;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        HXCourseDetailCourseTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXCourseDetailCourseTitleCell"];
        if(!cell){
            
            cell = [HXCourseDetailCourseTitleCell initCourseDetailCourseTitleCellWithXib];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.nav = self.navigationController;
        cell.pdModel = self.curriculumDetailModel.pd;
        cell.count = [NSString stringWithFormat:@"%ld",self.catalogueModel.varList.count];
        return cell;
        
    }else {
        
        HXCourseDetailIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXCourseDetailIntroduceCell"];
        if(!cell){
            
            cell = [HXCourseDetailIntroduceCell initCourseDetailIntroduceCellWithXib];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 1) {
            cell.showAllBtn.hidden = NO;
            cell.titleLab.text = @"课程简介";
        }
        cell.pdModel = self.curriculumDetailModel.pd;
        return cell;
    
    }
 
    return nil;
}



@end
