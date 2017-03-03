//
//  HXPayDetailTVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXPayDetailTVC.h"
#import "HXPayWaysCell.h"
#import "HXPayInformationCell.h"


@interface HXPayDetailTVC ()

//@property(nonatomic,strong) NSMutableArray *rowHeightArr;

@end

@implementation HXPayDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
   //支付详情
    self.title = @"详情";
    
    [self tableHead];
    
    
}

- (void)tableHead{

    UIView *tableHead = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(260)) backColor:kWhiteColor];
    //图片
    UIImageView *iconImagV = [UIImageView lh_imageViewWithFrame:CGRectMake(WidthScaleSize_W(28), WidthScaleSize_H(10), SCREEN_WIDTH - WidthScaleSize_W(28), WidthScaleSize_H(170)) image:[UIImage imageNamed:@"04"]];
    [tableHead addSubview:iconImagV];
    
    //课程标题
    UILabel *courseTitle = [UILabel lh_labelWithFrame:CGRectMake(iconImagV.mj_x, iconImagV.mj_y , iconImagV.mj_w, WidthScaleSize_H(60)) text:@"钢琴基础即兴伴奏教学" textColor:TitleGrayColor font:FONT(18) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
    [tableHead addSubview:courseTitle];
    
    //下划线
    UIImageView *downLine = [UIImageView lh_imageViewWithFrame:CGRectMake(courseTitle.mj_x, courseTitle.mj_y , courseTitle.mj_w, WidthScaleSize_H(2)) image:[UIImage imageNamed:@"Line"]];
    [tableHead addSubview:downLine];
    
    self.tableView.tableHeaderView = tableHead;


}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        HXPayInformationCell *informationCell = [tableView dequeueReusableCellWithIdentifier:@"informationCell"];
        if(!informationCell){
            informationCell = [HXPayInformationCell initPayInformationCellWithXib];
        
        }
        return informationCell;
        
    }else{
      
        HXPayWaysCell *payWayCell = [tableView dequeueReusableCellWithIdentifier:@"HXPayWaysCell"];
        if (!payWayCell) {
            payWayCell = [HXPayWaysCell initPayWaysCellWithXib];
        }
    
        return payWayCell;
    
    }
    
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (indexPath.row == 0) {
        
        return WidthScaleSize_H(125);
        
    }else{
    
        return WidthScaleSize_H(220);
    }
  

}



@end
