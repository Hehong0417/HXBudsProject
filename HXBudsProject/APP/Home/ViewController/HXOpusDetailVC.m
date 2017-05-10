//
//  HXOpusDetailVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXOpusDetailVC.h"
#import "HXopusDetailCellOne.h"
#import "HXopusDetailCellTwo.h"
#import "HXCourseDetailIntroduceCell.h"


@interface HXOpusDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)   UITableView *OpusDetailTable;

@end

@implementation HXOpusDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"作品详情";
    //tableView
    self.OpusDetailTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStylePlain];
    self.OpusDetailTable.delegate = self;
    self.OpusDetailTable.dataSource = self;
    self.OpusDetailTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.OpusDetailTable];
    
    UIButton *reawardBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50) target:self action:@selector(reawardAction) image:nil title:@"打赏作品" titleColor:kWhiteColor font:FONT(16)];
    reawardBtn.backgroundColor = APP_COMMON_COLOR;
    [self.view addSubview:reawardBtn];
    
    [self.OpusDetailTable registerNib:[UINib nibWithNibName:@"HXopusDetailCellOne" bundle:nil] forCellReuseIdentifier:@"HXopusDetailCellOne"];
     [self.OpusDetailTable registerNib:[UINib nibWithNibName:@"HXopusDetailCellTwo" bundle:nil] forCellReuseIdentifier:@"HXopusDetailCellTwo"];
    
}
- (void)reawardAction {

  
}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HXopusDetailCellOne *cell = [tableView dequeueReusableCellWithIdentifier:@"HXopusDetailCellOne"];
        return cell;
        
    }else if (indexPath.section == 1){
         if (indexPath.row == 0) {
         HXopusDetailCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:@"HXopusDetailCellTwo"];
         return cell;

        }else{
        
            HXCourseDetailIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXCourseDetailIntroduceCell"];
            
                if(!cell){
                    cell = [HXCourseDetailIntroduceCell initCourseDetailIntroduceCellWithXib];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                return cell;
        }
    
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
    return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 265;
    }else{
        if (indexPath.row == 0) {
            
            return 70;
        }else {
            return 110;
        }
    }
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXOpusDetailVC *vc = [[HXOpusDetailVC alloc]init];
    [self.navigationController pushVC:vc];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

@end
