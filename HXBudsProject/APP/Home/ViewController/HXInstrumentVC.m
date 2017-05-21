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
#import "HXCurriculumSearchAPI.h"
#import "HXSubjectVideoListModel.h"

@interface HXInstrumentVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)HXSubjectVideoListModel *instrumentModel;
@end

@implementation HXInstrumentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.type_name;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self getInstrumentData];
    
}
- (void)getInstrumentData{

    [[[HXCurriculumSearchAPI getsearchCurriculumListWithCurr_title:nil teachingtype_id:self.teachingtype_id] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
       
        HXSubjectVideoListModel *api = [HXSubjectVideoListModel new];
        
        self.instrumentModel = [api.class mj_objectWithKeyValues:responseObject];

        [self.tableView reloadData];
    }];
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.instrumentModel.varList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return WidthScaleSize_H(0.01);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        return 100;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        HXInstrumentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXInstrumentCell"];
        if(!cell){
            
            cell = [HXInstrumentCell initInstrumentCellWithXib];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
     cell.model = self.instrumentModel.varList[indexPath.row];
        return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    HXInstrumentSectionHead *sectionHead = [HXInstrumentSectionHead initInstrumentSectionHeadWithXib];
    sectionHead.backgroundColor = KVCBackGroundColor;
    sectionHead.courseCount.text = [NSString stringWithFormat:@"共%ld门相关课程",self.instrumentModel.varList.count?self.instrumentModel.varList.count:0];
    return sectionHead;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
        HXCourseDetailAnotherVC *vc = [HXCourseDetailAnotherVC new];
        HXSubjectVideoModel *model = self.instrumentModel.varList[indexPath.row];
        vc.curriculum_id = model.curriculum_id;
        vc.playImageStr = model.curr_picture;
        vc.curriculum_price = model.curriculum_price;
        vc.charge_status_text = model.charge_status_text;
        [self.navigationController pushVC:vc];
        
    
}



@end
