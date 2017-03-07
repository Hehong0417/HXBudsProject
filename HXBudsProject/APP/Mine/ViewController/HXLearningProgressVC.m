//
//  HXLearningProgressVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXLearningProgressVC.h"
#import "UIScrollView+EmptyDataSet.h"
#import "HXCourseListVC.h"

@interface HXLearningProgressVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,strong)UITableView *tabView;

@end

@implementation HXLearningProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *titles  = @[@"  正在学习",@"学习历程"];
    //112 198 199
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:titles];
    
    [segment lh_setCornerRadius:15 borderWidth:1 borderColor:kWhiteColor];
    segment.tintColor = kWhiteColor ;
    segment.selectedSegmentIndex = 0;
    NSDictionary *selectedTextAttributes = @{NSFontAttributeName :FONT(14),NSForegroundColorAttributeName:RGB(112, 198,199)};
    [segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary *unselectedTextAttributes = @{NSFontAttributeName :FONT(14),NSForegroundColorAttributeName:kWhiteColor};
    [segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    [segment setBackgroundImage:[UIImage imageWithColor:kWhiteColor] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [segment setBackgroundImage:[UIImage imageWithColor:RGB(112, 198,199)] forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
    [segment addTarget:self action:@selector(segmentSelectAction:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segment;
    
    self.tabView = [UITableView lh_tableViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
    [self.view addSubview:self.tabView];
    self.tabView.emptyDataSetSource = self;
    self.tabView.emptyDataSetDelegate = self;

}
- (void)segmentSelectAction:(UISegmentedControl *)segment {
    
    NSLog(@"%ld",segment.selectedSegmentIndex);
    
}
//
#pragma mark --- emptyDataSet delegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    
    return [UIImage imageNamed:@"placeholder"];
    
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{

    NSString *text = @"找课程去>>";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor blueColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];

}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return - 62.0f;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {

    HXCourseListVC *vc = [HXCourseListVC new];
    vc.isHomeEntrance = YES;
    [self.navigationController pushVC:vc];


}

#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"课程%ld",indexPath.row];
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
    
}


@end
