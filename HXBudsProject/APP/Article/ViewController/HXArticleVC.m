//
//  HXArticleVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXArticleVC.h"
#import "HXSectionHead.h"
#import "HXArticleCellTwo.h"
#import "HXArticleCellOne.h"
#import "HXArticleDetailVC.h"

@interface HXArticleVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tabView;

@end

@implementation HXArticleVC

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
    
    if (indexPath.section == 0) {
        
        HXArticleCellOne *cell = [tableView dequeueReusableCellWithIdentifier:@"HXArticleCellOne"];
        if(!cell){
        
            cell = [[HXArticleCellOne alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HXArticleCellOne"];
        
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.subjectArr = @[@"#智商·情商#",@"#叶文有话要说#",@"#单田方#",@"#城市#",@"#美女#",@"#社交恐惧#",@"#家庭矛盾#"];
        cell.vc = self.navigationController;
        return cell;
        
    }
    HXArticleCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:@"HXArticleCellTwo"];
    if (!cell) {
        
        cell = [HXArticleCellTwo initArticleCellTwoWithXib];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ContentType contentType;
    NSString *imageName;
    NSString *titleName;
    NSString *headTitle;
    if (section == 0) {
        headTitle = @"  话题";
        contentType = LeftImageRightTitle;
        imageName = @"";
        titleName = @"";
        
    }else if (section == 1) {
        headTitle = @"  都在看头条";
        contentType = LeftImageRightTitle;
        imageName = @"";
        titleName = @"";
        
    }
    
    HXSectionHead *sectionHead = [[[HXSectionHead alloc] init] createSectionHeadWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(35)) section:(NSInteger)section headTitle:headTitle discrib:@"为你的梦想保驾护航" contenType:contentType rightBtnTitle:titleName imageName:imageName labFont:FONT(14) buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:FontLightGrayColor fontsize:14]];
    
    return sectionHead;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1) {
        
        HXArticleDetailVC *vc = [HXArticleDetailVC new];
        [self.navigationController pushVC:vc];
        
    }
    

}
@end
