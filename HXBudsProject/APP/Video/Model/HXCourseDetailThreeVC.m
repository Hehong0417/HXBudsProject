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

@interface HXCourseDetailThreeVC ()<UITableViewDelegate, UITableViewDataSource,HXGradeCommentCellDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HXCourseDetailThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //评价
    [self addTableView];

    
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
        
        return 3;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return WidthScaleSize_H(124);
        
    }else {
        
        return  WidthScaleSize_H(80);
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

  //弹框
    HXGradeCommentView *commentView = [[HXGradeCommentView alloc]init];
    [commentView showAnimated:YES];


}


@end
