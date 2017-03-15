//
//  HXCourseClassifyVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/20.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseClassifyVC.h"
#import "HXCourseHeadView.h"
#import "HXCourseCell.h"
#import "HXCourseDetailAnotherVC.h"

#import <AFNetworking.h>

#import "XLVideoItem.h"

#define videoListUrl @"http://c.3g.163.com/nc/video/list/VAP4BFR16/y/0-10.html"


@interface HXCourseClassifyVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *videoArray;

@end

@implementation HXCourseClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"精品课程";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH,SCREEN_HEIGHT+20) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    
    HXCourseHeadView *head =  [HXCourseHeadView initCourseHeadViewWithXib];
    head.frame = CGRectMake(0, -20, SCREEN_WIDTH, WidthScaleSize_H(112));
    [head.backBtn setTapActionWithBlock:^{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    self.tableView.tableHeaderView = head;
    self.tableView.showsVerticalScrollIndicator = NO;
//    [self fetchVideoListData];

}
#pragma mark - network

//- (void)fetchVideoListData {
//    
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:videoListUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//                NSLog(@"%@", responseObject);
//        NSArray *dataArray = responseObject[@"VAP4BFR16"];
//        
//        for (NSDictionary *dict in dataArray) {
//            [self.videoArray addObject:[XLVideoItem mj_objectWithKeyValues:dict]];
//            
//        }
//        [self.tableView reloadData];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
//}

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

    return WidthScaleSize_H(281);

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    HXCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXCourseCell"];
    if(!cell){
    
        cell = [HXCourseCell initCourseCellWithXib];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//     XLVideoItem *item = self.videoArray[indexPath.row];
//    [ cell.playBgImageV sd_setImageWithURL:[NSURL URLWithString:item.cover]];
    
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    XLVideoItem *item = self.videoArray[indexPath.row];

    HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
    vc.URLString = @"http://yycloudvod2109130935.bs2dl.yy.com/djhmZjcyZTExZDRiZmY1Yzg0NzhlM2Q5MWVjZjRhYzY1MTUzNDQxMjM1Mg";
    [self.navigationController pushVC:vc];

}
- (NSMutableArray *)videoArray {
    if (!_videoArray) {
        _videoArray = [NSMutableArray array];
    }
    return _videoArray;
}

@end
