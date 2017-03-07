//
//  HXCouponVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/3.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCouponVC.h"
#import "UIScrollView+EmptyDataSet.h"

@interface HXCouponVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView *tabView;
@property(nonatomic,strong) UIButton *currentSelectBtn;

@end

@implementation HXCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
  

    self.automaticallyAdjustsScrollViewInsets = NO;
    

    NSArray *titles  = @[@"可用优惠券",@"历史优惠券"];

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
    
    //兑换框
    UITextField *convert_box = [UITextField lh_textFieldWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 38) placeholder:@"输入活动优惠码" font:FONT(14) textAlignment:NSTextAlignmentLeft backgroundColor:nil];
    [convert_box setBackground:[UIImage imageNamed:@"convert_box"]];
    convert_box.leftViewMode = UITextFieldViewModeAlways;
    convert_box.rightViewMode = UITextFieldViewModeAlways;
    UIImageView *imgV =  [UIImageView lh_imageViewWithFrame:CGRectMake(0, 0, 35, 38) image:[UIImage imageNamed:@"discount"]];
    imgV.contentMode = UIViewContentModeCenter;
    convert_box.leftView = imgV;
    [self.view addSubview:convert_box];
    UILabel *convertLab = [UILabel lh_labelWithFrame:CGRectMake(0, 0, 38, 38) text:@"兑换" textColor:kLightGrayColor font:FONT(14) textAlignment:NSTextAlignmentCenter backgroundColor:kClearColor];
    convert_box.rightView = convertLab;
    UIView *leftLine = [UIView lh_viewWithFrame:CGRectMake(0, 0, 1, 38) backColor:kLightGrayColor];
    [convertLab addSubview:leftLine];
    
    
//    //tabView
    self.tabView = [UITableView lh_tableViewWithFrame:CGRectMake(0, 62, SCREEN_WIDTH, SCREEN_HEIGHT - 62) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
    [self.view addSubview:self.tabView];
    self.tabView.emptyDataSetSource = self;
    self.tabView.emptyDataSetDelegate = self;

}

- (void)segmentSelectAction:(UISegmentedControl *)segment {

    NSLog(@"%ld",segment.selectedSegmentIndex);

}



#pragma mark --- emptyDataSet delegate
//
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{

    
    return [UIImage imageNamed:@"placeholder"];

}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"没有优惠券!";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return - 62.0f;
}

#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"优惠券%ld",indexPath.row];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
    
}



@end
