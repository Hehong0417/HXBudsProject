//
//  HXCourseOneVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/10.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCourseOneVC.h"
#import "HXMessageCell.h"

@interface HXCourseOneVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tabView;


@end

@implementation HXCourseOneVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.tabView = [UITableView lh_tableViewWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabView];
    self.tabView.showsVerticalScrollIndicator = NO;
    self.tabView.backgroundColor = kWhiteColor;

}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        HXMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXArticleCellOne"];
        if(!cell){
            
            cell = [HXMessageCell initMessageCellWithXib];
        }
        return cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 100;
    }else{
        
        return 135;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return WidthScaleSize_H(40);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

@end
