//
//  HXPersonCenterVC.m
//  HXBudsProject
//
//  Created by n on 2017/2/7.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXPersonCenterVC.h"
#import "HXMineLearnCell.h"
#import "HXMineHeadView.h"
#import "HXMyAccountInfoVC.h"
#import "HXCouponVC.h"
#import "HXMyLikeVC.h"
#import "HXMineLoginHeadView.h"
#import "HXMyArticleVC.h"
#import "HXMyAttentionSGVC.h"
#import "HXFriendDynamicStateVC.h"
#import "HXAdviceFaceBackVC.h"
#import "HXBrowserRecordVC.h"
#import "HXMessageVC.h"
#import "HXMyVideoVC.h"
#import <UShareUI/UShareUI.h>
#import "HXIsLoginAPI.h"
#import "HJUser.h"


@interface HXPersonCenterVC ()<HXMineLearnCellDelegate>

@end

@implementation HXPersonCenterVC


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self isLoginCompleteHandle:^(BOOL isLogin) {
        
        if (isLogin) {
            
        }
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self isLoginCompleteHandle:^(BOOL isLogin) {
        UIView *headView;
        if (isLogin) {
           headView = [self isLoginState];
        }else{
        
            headView = [self isNoLoginState];
        }
        self.tableV.tableHeaderView = headView;

    }];
    
   
    //
    

    
}
- (UIView *)isNoLoginState{

    HXMineHeadView *mineHeadView = [HXMineHeadView initmineHeadViewWithXib];
    mineHeadView.frame = CGRectMake(0, -20, SCREEN_WIDTH, WidthScaleSize_H(120));
    mineHeadView.nav = self.navigationController;
    return mineHeadView;
}
- (UIView *)isLoginState{

        HXMineLoginHeadView *mineHeadView = [HXMineLoginHeadView initMineLoginHeadViewWithXib];
        mineHeadView.frame = CGRectMake(0, -20, SCREEN_WIDTH, WidthScaleSize_H(120));
        mineHeadView.nav = self.navigationController;

        [mineHeadView setTapActionWithBlock:^{

            HXMyLikeVC *vc = [HXMyLikeVC new];
            vc.titleStr = @"我的主页";
            vc.dynamicType = mineDynamicType;
            [self.navigationController pushVC:vc];
    
        }];
    return mineHeadView;
}
- (void)isLoginCompleteHandle:(void (^)(BOOL isLogin))CompleteHandle{

    HJLoginModel *loginModel = [HJUser sharedUser].pd;
    [[[HXIsLoginAPI isLoginWithToken:loginModel.token] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        BOOL isLogin = responseObject[@"pd"][@"islogin"];
        CompleteHandle(isLogin);
    }];
    
}
- (NSArray *)groupTitles {
    
    return @[@[@""],@[@"我的资产",@"我的消息",@"我关注的",@"好友动态"],@[@"浏览记录",@"分享萌芽APP",@"意见反馈",@"给我们好评~~"],@[@"仅在WI-Fi下播放"]];
}

- (NSArray *)groupIcons {
    
    return @[@[@""],@[@"mine_0",@"mine_1",@"mine_2",@"mine_3"],@[@"mine_4",@"mine_5",@"mine_6",@"mine_7"],@[@""]];
    
}

- (NSArray *)rightViewSwitchIndexPaths {
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:3];
    
    return @[indexpath];
}

- (NSArray *)groupDetials {
    
    return @[@[@""],@[@"",@"",@"",@""],@[@"",@"",@"",@""],@[@""]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HXMineLearnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXMineLearnCell"];
        
        if (!cell) {
            
            cell = [HXMineLearnCell initMineCellWithXib];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else {
        
        UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell;
        
    }
    return nil;
}

- (void)leftBtnAction:(UIButton *)btn {
    
    NSLog(@"left");
    //我的文章
    HXMyArticleVC *vc = [HXMyArticleVC new];
    vc.articleType = mineArticle;
    [self.navigationController pushVC:vc];
    
}
- (void)rightBtnAction:(UIButton *)btn {
    
    NSLog(@"right");
    //我的视频
    HXMyVideoVC *vc = [HXMyVideoVC new];
    vc.videoType = mineVideo;

    [self.navigationController pushVC:vc];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        [self didSelectRowAtSection0:indexPath.row];
        
    }else if (indexPath.section == 2){
        
        [self didSelectRowAtSection1:indexPath.row];
    }
    
}

- (void)didSelectRowAtSection0:(NSInteger )row{
    
    if (row == 0) {
        
        HXMyAccountInfoVC *vc = [HXMyAccountInfoVC new];
        [self.navigationController pushVC:vc];
        
    }else if (row == 1){
        HXMessageVC *vc = [HXMessageVC new];
        [self.navigationController pushVC:vc];
        
    }else if (row == 2){
        HXMyAttentionSGVC *vc = [HXMyAttentionSGVC new];
        [self.navigationController pushVC:vc];
        
    }else if (row == 3){
        HXFriendDynamicStateVC *vc = [HXFriendDynamicStateVC new];
        [self.navigationController pushVC:vc];
        
    }
}
- (void)didSelectRowAtSection1:(NSInteger)row{
    
    if (row == 0) {
        HXBrowserRecordVC *vc = [HXBrowserRecordVC new];
        [self.navigationController pushVC:vc];
        
    }else if (row == 1){
        
        //分享app
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:platformType];
            
        }];
        
    }else if (row == 2){
        HXAdviceFaceBackVC *vc = [HXAdviceFaceBackVC new];
        [self.navigationController pushVC:vc];
        
    }else if (row == 3){
        
        
        
    }
    
}
- (void)LearnBtnActionWithIndex:(NSInteger)index {
    
    
    
    
}
//分享网页链接
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"萌芽-多艺盟" descr:@"艺术教育平台" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [self alertWithError:error];
    }];
}

@end
