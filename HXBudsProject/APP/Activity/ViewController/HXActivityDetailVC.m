//
//  HXActivityDetailVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXActivityDetailVC.h"
#import "HXActivityDetailHead.h"
#import "HXActivityDetailCell.h"
#import "HXActivityDetailContentCell.h"
#import "FXBlurView.h"

@interface HXActivityDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation HXActivityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = APP_COMMON_COLOR;
    self.tableView.backgroundColor = KVCBackGroundColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH,SCREEN_HEIGHT+20) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    
    HXActivityDetailHead *head =  [HXActivityDetailHead initActivityDetailHeadWithXib];
    head.frame = CGRectMake(0, -20, SCREEN_WIDTH, WidthScaleSize_H(230));
    UIImage *bgImage = [[UIImage imageNamed:@"Bitmap"] lh_captureImageWithRect:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(230))];
    
//    UIImage *bgImage = [UIImage imageNamed:@"Bitmap"];
    head.bgImageV.image = bgImage;
                       
    FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(230))];
    blurView.dynamic = NO;
    blurView.tintColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    blurView.iterations = 3; //像素偏移度
    blurView.blurRadius = 20; //模糊程度
    [head.bgImageV addSubview:blurView];
    
    [head.backBtn setTapActionWithBlock:^{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    self.tableView.tableHeaderView = head;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    


}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.row == 0) {
        
        HXActivityDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"HXActivityDetailCell"];
        
        if (!detailCell) {
         detailCell = [HXActivityDetailCell initActivityDetailCellWithXib];
        }
        detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return detailCell;
        
    }else if(indexPath.row == 1){
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"活动详情";
        
        return cell;
    }else {
    
        HXActivityDetailContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier: @"HXActivityDetailContentCell"];
        if (!contentCell) {
            contentCell = [[HXActivityDetailContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HXActivityDetailContentCell"];
            }
        contentCell.textView.text = @"活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情";
        contentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return contentCell;

    
    }
  

    return nil;

}

@end
