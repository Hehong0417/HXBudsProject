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
    UIButton *saveBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 80, 80) target:self action:@selector(saveAction:) title:@"保存" titleColor:APP_COMMON_COLOR font:FONT(16) backgroundColor:kClearColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];

    self.testArr = [NSMutableArray arrayWithObjects:@"2",@"3",@"4", nil];
    
    self.tableV.backgroundColor = KVCBackGroundColor;
    
    
//    UIButton *exitBtn = [UIButton lh_buttonWithFrame:CGRectMake(60, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>) target:<#(id)#> action:<#(SEL)#> image:<#(UIImage *)#> title:<#(NSString *)#> titleColor:<#(UIColor *)#> font:<#(UIFont *)#>]
}

- (void)saveAction:(UIButton *)btn{
 
    [self.navigationController popVC];


}
- (NSArray *)groupTitles {
    
    return @[@[@"头像",@"昵称",@"手机",@"姓名",@"性别",@"年龄"],@[@""]];
}

- (NSArray *)groupIcons {
    
    return @[@[@" ",@" ",@" ",@" ",@" ",@" "],@[@""]];
    
}
- (NSArray *)textFieldTitles{
    
    return self.testArr;
    
}


- (NSArray *)groupDetials {
    
    return @[@[@" ",@" ",@" ",@" ",@" ",@" "],@[@""]];
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
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        IQTextView *introduce = [[IQTextView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, WidthScaleSize_H(100))];
        introduce.font = FONT(14);
        introduce.placeholder = @"个人概述";
        
        [cell addSubview:introduce];
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0&&indexPath.row == 0) {
        
        return 70;

    }else if (indexPath.section == 1&&indexPath.row == 0){
    
        return 100;

    }else{
        
        return  44;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        UIView *head = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20) backColor:LineLightColor];
        UILabel *Label = [UILabel lh_labelWithFrame:CGRectMake(15, 0, 100, 20) text:@"个人概述" textColor:FontLightGrayColor font:FONT(13) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
        [head addSubview:Label];
        return head;

    }else{
   
     return nil;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.001;
    }else{
        return 20;
    }
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
    }else{
    
        [super  tableView:tableView didSelectRowAtIndexPath:indexPath];
    }

}

@end
