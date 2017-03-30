//
//  HXCourseDetailTwoVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseDetailTwoVC.h"

@interface HXCourseDetailTwoVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HXCourseDetailTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTableView];
    
    
}
- (void)addTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-WidthScaleSize_H(200)-WidthScaleSize_H(44)-64- WidthScaleSize_H(49)) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor colorWithWhite:0.8 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    _tableView.rowHeight = 44;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"   %ld、钢琴基础即兴伴奏教学",indexPath.row+1];
    cell.textLabel.font = FONT(14);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



@end
