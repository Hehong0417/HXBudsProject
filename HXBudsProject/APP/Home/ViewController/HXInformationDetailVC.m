
//
//  HXInformationDetailVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXInformationDetailVC.h"
#import "HXWebViewCell.h"
#import "HXUseFulCell.h"
#import "HXCourseDetailCommentCell.h"
#import "HXInformationCommentView.h"


@interface HXInformationDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tabView;

@end

@implementation HXInformationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"艺考资讯";
    
    self.tabView = [UITableView lh_tableViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 64 - 47) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
    [self.view addSubview:self.tabView];
    
    HXInformationCommentView *commentView = [HXInformationCommentView initInformationCommentViewWithXib];
    commentView.frame = CGRectMake(0, SCREEN_HEIGHT - 47 - 64 , SCREEN_WIDTH, 47);
    [self.view addSubview:commentView];
    
}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:{
            HXWebViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXWebViewCell"];
            if (!cell) {
                cell = [[HXWebViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                
            }
            
            cell.urlStr = @"https://www.baidu.com";
            
            return cell;
            
                  }
            break;
        case 1:{
            
            HXUseFulCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXUseFulCell"];
            if (!cell) {
                cell = [HXUseFulCell initUseFulCellWithXib];
            
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        default:{
            
            HXCourseDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXCourseDetailCommentCell"];
            if (!cell) {
                cell = [HXCourseDetailCommentCell initCourseDetailCommentCellWithXib];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;

        
        }
            break;
    }
    
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            
            return WidthScaleSize_H(345);
            break;
        }
        case 1:
            return WidthScaleSize_H(235);
            break;
        case 2:
            return WidthScaleSize_H(80);

            break;
        default:
            break;
    }

    return 0;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        return WidthScaleSize_H(30);
    }else{
    
        return 0.01;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
        default:
            break;
    }
    
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 
    if (section == 2) {
        UILabel *sectionLab = [UILabel lh_labelWithFrame:CGRectMake(0, 0, 80, WidthScaleSize_H(30)) text:@"   评论2" textColor:kBlackColor font:FONT(14) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
        return sectionLab;
    }else {
    
        return nil;
    }

}

@end
