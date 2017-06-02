//
//  HXCourseDetailThreeVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseDetailThreeVC.h"
#import "HXCourseDetailCommentCell.h"
#import "HXGradeCommentCell.h"
#import "HXGradeCommentView.h"
#import "HXcurriculumreviewAPI.h"
#import "HXcurriculumreviewModel.h"
#import "HXReViewAddAPI.h"
#import "HXSpotFabulousAPI.h"
#import "HXLoginVC.h"
#import "HXIsLoginAPI.h"


@interface HXCourseDetailThreeVC ()<UITableViewDelegate, UITableViewDataSource,HXGradeCommentCellDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HXcurriculumreviewModel *reviewModel;
@property(nonatomic,assign)BOOL isLogin;

@end

@implementation HXCourseDetailThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //评价
    [self addTableView];
    
    //判断是否已登录
    HJUser *user = [HJUser sharedUser];
    [[[HXIsLoginAPI isLoginWithToken:user.pd.token] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        if (error==nil) {
        NSString *isLoginStr = responseObject[@"pd"][@"islogin"];
        if ([isLoginStr isEqualToString:@"no"]) {
            self.isLogin = NO;
        }else {
            self.isLogin = YES;
        }
        }
    }];
    
    
    [self getcurriculumreviewData];
}
- (void)getcurriculumreviewData{
    
    [[[HXcurriculumreviewAPI getcurriculumReviewWithCurriculum_id:self.curriculum_id limit:@4] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        if (error==nil) {
        HXcurriculumreviewModel *api = [HXcurriculumreviewModel new];
        self.reviewModel = [api.class mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];
        }
    }];
    
}

- (void)addTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - WidthScaleSize_H(200) - WidthScaleSize_H(44)- 64- WidthScaleSize_H(49)) style:UITableViewStyleGrouped];
    _tableView.separatorColor = [UIColor colorWithWhite:0.8 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44;
    _tableView.backgroundColor = kWhiteColor;

    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }else{
        
        return self.reviewModel.varList.count;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 124;
        
    }else {
        
        return  80;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        HXGradeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXGradeCommentCell"];
        if(!cell){
            
            cell = [[HXGradeCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HXGradeCommentCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
            cell.delegate = self;
        return cell;
        
    }else {
        
        HXCourseDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXCourseDetailCommentCell"];
        if(!cell){
            
            cell = [HXCourseDetailCommentCell initCourseDetailCommentCellWithXib];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        HXcurriculumreviewVarListModel *model = self.reviewModel.varList[indexPath.row];
        cell.model = model;
        cell.tip.userInteractionEnabled = YES;
        
        //点赞
        [cell.tip setTapActionWithBlock:^{
            if (self.isLogin) {
                [[[HXSpotFabulousAPI addSpotFabulousWithcurriculumreview_id:model.curriculumreview_id] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
                    if (error==nil) {
                    NSString *status = responseObject[@"pd"][@"status"];
                    if ([status isEqualToString:@"no"]) {
                        [self getcurriculumreviewData];

                        }else {
                    }
                    }
                }];
                
            }else{
                [self.navigationController pushVC:[HXLoginVC new]];
            
            }
            
        }];
        return cell;
        
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01;
}

#pragma mark - HXGradeCommentCellDelegate 

- (void)gradeCommentStarAction:(UIButton *)button {

    if (self.isLogin) {
        
        //弹框
        HXGradeCommentView *commentView = [[HXGradeCommentView alloc]init];
        commentView.addReviewBlock = ^(NSString *content, NSNumber *starNum){
            
            [[[HXReViewAddAPI addReViewWithcurriculum_id:self.curriculum_id review_content:content star:starNum] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
                if (error==nil) {
                [self getcurriculumreviewData];
                }
            }];
            
        };
        [commentView showAnimated:YES];
    }else{
    
        [self.navigationController pushVC:[HXLoginVC new]];
    
    }
}


@end
