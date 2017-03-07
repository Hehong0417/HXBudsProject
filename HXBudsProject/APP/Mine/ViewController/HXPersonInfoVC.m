//
//  HXPersonInfoVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/2.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXPersonInfoVC.h"
#import "HXCommonPickView.h"
@interface HXPersonInfoVC ()
@property(nonatomic,strong)NSMutableArray *testArr;

@end

@implementation HXPersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title = @"个人信息";
    UIButton *saveBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 80, 80) target:self action:@selector(saveAction:) title:@"保存" titleColor:kWhiteColor font:FONT(16) backgroundColor:kClearColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];

    self.testArr = [NSMutableArray arrayWithObjects:@"2",@"3",@"4", nil];
    
    
}

- (void)saveAction:(UIButton *)btn{
 
//    [self.navigationController popVC];


}
- (NSArray *)groupTitles {
    
    return @[@[@"头像",@"昵称",@"手机",@"姓名",@"性别",@"年龄"]];
}

- (NSArray *)groupIcons {
    
    return @[@[@" ",@" ",@" ",@" ",@" ",@" "]];
    
}
- (NSArray *)textFieldTitles{
    
    return self.testArr;
    
}


- (NSArray *)groupDetials {
    
    return @[@[@" ",@" ",@" ",@" ",@" ",@" "]];
}
- (NSArray *)textFieldCellIndexPaths{
    
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
    NSIndexPath *indexPath3 = [NSIndexPath indexPathForRow:3 inSection:0];
    
    return @[indexPath1,indexPath2,indexPath3];
    
}
- (NSIndexPath *)headImageCellIndexPath{

    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];

    return indexpath;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

   
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        return WidthScaleSize_H(70);
    }
    
   return  WidthScaleSize_H(44);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 4) {
        //性别
        HXCommonPickView *pickView = [[HXCommonPickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        pickView.style = HXCommonPickViewStyleSex;
        [pickView showPickViewAnimation:YES];
        
        pickView.completeBlock = ^(NSString *selectedItem){
        
        
        
        };
        
    }else if(indexPath.row == 5){
        //年龄
        HXCommonPickView *pickView = [[HXCommonPickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        pickView.style = HXCommonPickViewStyleDate;
        [pickView showPickViewAnimation:YES];
        
        pickView.completeBlock = ^(NSString *selectedItem){
            
            
            
        };

    }

}

@end
