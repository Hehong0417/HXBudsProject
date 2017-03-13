//
//  HXCourseDetailVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseDetailVC.h"
#import "MainTouchTableTableView.h"
#import "MYSegmentView.h"
#import "HXCourseDetailOneVC.h"
#import "HXCourseDetailTwoVC.h"
#import "HXCourseDetailThreeVC.h"
#import "HXBuyBottomView.h"


@interface HXCourseDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign) BOOL canScroll;
@property(nonatomic,assign) BOOL isTopIsCanNotMoveTableView;
@property(nonatomic,assign) BOOL isTopIsCanNotMoveTabViewPre;
@property(nonatomic,strong) MainTouchTableTableView *tableView;
@property(nonatomic,strong) MYSegmentView *segmentView;
@property(nonatomic,strong) UIView *headView;
@property(nonatomic,strong) HXBuyBottomView *buyBottomView;
@property(nonatomic,assign) BOOL notScroll;
@end

static CGFloat const headViewHeight = 200.0f;

@implementation HXCourseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"课程详情";
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.headView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(leaveTop:) name:@"leaveTop" object:nil];
    
    
    [self.view addSubview:self.buyBottomView];
    
    _notScroll = YES;
    
    
    
}

- (void)leaveTop:(NSNotification *)notification{

    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {


//    CGFloat yOffset = scrollView.contentOffset.y;
    
    
    CGFloat tabOffsetY = [_tableView rectForSection:0].origin.y;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    
    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTableView;
    
    if (offsetY >= tabOffsetY) {
        
        scrollView.contentOffset = CGPointMake(0, 0);
        _isTopIsCanNotMoveTableView = YES;
        //到顶了
    }else {
        //没到顶
        
           _isTopIsCanNotMoveTableView = NO;
            
    }
    
    
    if (_isTopIsCanNotMoveTableView != _isTopIsCanNotMoveTabViewPre) {
        
        if (_isTopIsCanNotMoveTableView && !_isTopIsCanNotMoveTabViewPre) {
            
            //子tableView到顶端了
            [[NSNotificationCenter defaultCenter]postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
            
        }
        
        
        if (!_isTopIsCanNotMoveTableView && _isTopIsCanNotMoveTabViewPre) {
            
            if (!_canScroll) {
                
                scrollView.contentOffset = CGPointMake(0, tabOffsetY);
                
            }
        }
    }
 
}



- (UIView *)headView{
  
    if (!_headView) {
        _headView = [UIView lh_viewWithFrame:CGRectMake(0, -headViewHeight , SCREEN_WIDTH,headViewHeight) backColor:kWhiteColor];
        
      UIImageView *imageV =  [UIImageView lh_imageViewWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,headViewHeight) image:[UIImage imageNamed:@"04"]];
      UIImageView *playImgV = [UIImageView lh_imageViewWithFrame:CGRectMake(0, 0, 80, 80) image:[UIImage imageNamed:@"play"] userInteractionEnabled:YES];
        playImgV.center = imageV.center;
        playImgV.contentMode = UIViewContentModeCenter;
        [_headView addSubview:imageV];
        [_headView addSubview:playImgV];
    }
   

    return _headView;

}

- (HXBuyBottomView *)buyBottomView {

    if (!_buyBottomView) {
        
        _buyBottomView = [[HXBuyBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - WidthScaleSize_H(49) -64 , SCREEN_WIDTH, WidthScaleSize_H(49))];
    }
    return _buyBottomView;

}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[MainTouchTableTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.contentInset = UIEdgeInsetsMake(headViewHeight, 0, 0, 0);
        _tableView.rowHeight = SCREEN_HEIGHT;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:self.segmentView];
    return cell;
}

- (UIView *)segmentView
{
    if(!_segmentView){
        
        HXCourseDetailOneVC *firstViewController = [[HXCourseDetailOneVC alloc] init];
        firstViewController.title = @"介绍";
        
        HXCourseDetailTwoVC *secondViewController = [[HXCourseDetailTwoVC alloc] init];
        secondViewController.title = @"目录";
        
        HXCourseDetailThreeVC *threeViewController = [[HXCourseDetailThreeVC alloc] init];
        threeViewController.title = @"评价";
        
        NSArray *controllerArray = @[firstViewController, secondViewController,threeViewController];
        NSArray *titleArray = @[@"介绍", @"目录",@"评价"];
        
        CGFloat lineWidth = [@"second" boundingRectWithSize:CGSizeMake(100, 21) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size.width;
        
        MYSegmentView *tempView = [[MYSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) controllers:controllerArray titleArray:titleArray ParentController:self lineWidth:lineWidth lineHeight:3.];
        _segmentView = tempView;
    }
    return _segmentView;
}

@end
