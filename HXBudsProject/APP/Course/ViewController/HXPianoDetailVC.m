//
//  HXPianoDetailVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXPianoDetailVC.h"
#import "SPullDownMenuView.h"
#import "HXPianoDetailCell.h"
#import "HXCourseDetailAnotherVC.h"

@interface HXPianoDetailVC ()<UITableViewDataSource, UITableViewDelegate, SPullDownMenuViewDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (nonatomic, strong) SPullDownMenuView *menu;
@property (strong, nonatomic) NSIndexPath *index;
@property (nonatomic, strong) NSArray *titleA;
@end

@implementation HXPianoDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"钢琴";
    self.automaticallyAdjustsScrollViewInsets = NO;
      [self createUI];
  
}
- (void)createUI{
    self.titleA = @[@[@"星级", @"价格从低到高", @"价格从高到底", @"信用排序"], @[@"等级", @"价格从低到高", @"价格从高到底", @"信用排序"]];
    self.menu = [[SPullDownMenuView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, WidthScaleSize_H(44)) withTitle:self.titleA withSelectColor:[UIColor colorWithHexString:@"#2D6B6D"]];
    
    if (self.isMyLike) {
        self.menu.hidden = YES;
    }else {
        self.menu.hidden = NO;
    }
    self.menu.delegate = self;
    [self.view addSubview:self.menu];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, WidthScaleSize_H(44), _menu.frame.size.width, SCREEN_HEIGHT - 64-WidthScaleSize_H(44)) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return WidthScaleSize_H(200);


}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HXPianoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXPianoDetailCell"];
    if (!cell) {
        cell = [HXPianoDetailCell initPianoDetailCellWithXib];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)pullDownMenuView:(SPullDownMenuView *)menu didSelectedIndex:(NSIndexPath *)indexPath{
    self.index = indexPath;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
    vc.URLString = @"http://yycloudvod2109130935.bs2dl.yy.com/djhmZjcyZTExZDRiZmY1Yzg0NzhlM2Q5MWVjZjRhYzY1MTUzNDQxMjM1Mg";
    [self.navigationController pushVC:vc];



}


@end
