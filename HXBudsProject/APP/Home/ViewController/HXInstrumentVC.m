//
//  HXInstrumentVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/9.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXInstrumentVC.h"
#import "HXInstrumentCell.h"
#import "HXCourseDetailAnotherVC.h"
#import "HXInstrumentSectionHead.h"


@interface HXInstrumentVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation HXInstrumentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"西洋乐器";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 35;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        
        return 90;
        
    }else if(indexPath.section == 1){
        
        return 70;
    }
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        HXInstrumentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXInstrumentCell"];
        if(!cell){
            
            cell = [HXInstrumentCell initInstrumentCellWithXib];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    HXInstrumentSectionHead *sectionHead = [HXInstrumentSectionHead initInstrumentSectionHeadWithXib];
  
    return sectionHead;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
        HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
        [self.navigationController pushVC:vc];
        
    
}



@end
