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
#import "HXBroserRecordSGVC.h"
#import "HXMessageVC.h"
#import "HXMyVideoVC.h"
#import <UShareUI/UShareUI.h>
#import "HXIsLoginAPI.h"
#import "HJUser.h"
#import "HXgetUserInfoAPI.h"
#import "HXLoginVC.h"

@interface HXPersonCenterVC ()<HXMineLearnCellDelegate>
{
  
}
//@property (nonatomic, strong) HXTeacherDetailModel *teacherDetailModel;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) HXMineLoginHeadView *mineHeadView;
@property (nonatomic, strong) HXMineHeadView *NoLoginMineHeadView;

@end

@implementation HXPersonCenterVC


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [self isLoginCompleteHandle:^(BOOL isLogin) {
        if (self.isLogin) {
            [self isLoginState];
        }else{
            
            [self isNoLoginState];
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //未登录的HeadView
    self.NoLoginMineHeadView = [HXMineHeadView initmineHeadViewWithXib];
    self.NoLoginMineHeadView.frame = CGRectMake(0, -20, SCREEN_WIDTH, WidthScaleSize_H(120));
    self.NoLoginMineHeadView.nav = self.navigationController;
    
    self.tableV.tableHeaderView =  self.NoLoginMineHeadView;

    //登录后的HeadView
    self.mineHeadView = [HXMineLoginHeadView initMineLoginHeadViewWithXib];
    self.mineHeadView.frame = CGRectMake(0, -20, SCREEN_WIDTH, WidthScaleSize_H(120));
    self.mineHeadView.nav = self.navigationController;
    
    
    [self isLoginCompleteHandle:^(BOOL isLogin) {
        if (self.isLogin) {
           [self isLoginState];
        }else{
        
            [self isNoLoginState];
        }
    }];
    
}
- (void)getMyInfoData{
    
    [[[HXgetUserInfoAPI getUserInfo] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        self.mineHeadView.nameLab.text = responseObject[@"pd"][@"username"];
        [self.mineHeadView.iconImagV sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(responseObject[@"pd"][@"headportrait"])] placeholderImage:[UIImage imageWithColor:KPlaceHoldColor]];
        self.tableV.tableHeaderView = self.mineHeadView;
    }];
    
}
- (void)isNoLoginState{

  
    self.tableV.tableHeaderView = self.NoLoginMineHeadView;

}
- (void)isLoginState{
    
    [self getMyInfoData];
    
//      self.mineHeadView.model = self.teacherDetailModel.pd;
        WEAK_SELF();
        [self.mineHeadView setTapActionWithBlock:^{

            HXMyLikeVC *vc = [HXMyLikeVC new];
            vc.titleStr = @"我的主页";
            vc.dynamicType = mineDynamicType;
            HJUser *user = [HJUser sharedUser];
            vc.users_id = user.pd.users_id;
            [weakSelf.navigationController pushVC:vc];
    
        }];
}
- (void)isLoginCompleteHandle:(void (^)(BOOL isLogin))CompleteHandle{

    HJLoginModel *loginModel = [HJUser sharedUser].pd;
    [[[HXIsLoginAPI isLoginWithToken:loginModel.token] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        NSString *isLoginStr = responseObject[@"pd"][@"islogin"];
        if ([isLoginStr isEqualToString:@"no"]) {
            self.isLogin = NO;
        }else {
            self.isLogin = YES;
        }
        CompleteHandle(self.isLogin);
    }];
    
}
- (NSArray *)groupTitles {
    
    return @[@[@"我的资产",@"我的消息",@"我关注的",@"好友动态"],@[@"浏览记录",@"分享萌芽APP",@"意见反馈",@"给我们好评~~"],@[@"仅在WI-Fi下播放",@""]];
}

- (NSArray *)groupIcons {
    
    return @[@[@"mine_0",@"mine_1",@"mine_2",@"mine_3"],@[@"mine_4",@"mine_5",@"mine_6",@"mine_7"],@[@"",@""]];
    
}

- (NSArray *)rightViewSwitchIndexPaths {
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:3];
    
    return @[indexpath];
}

- (NSArray *)groupDetials {
    
    return @[@[@"",@"",@"",@""],@[@"",@"",@"",@""],@[@"",@" "]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.section == 2 && indexPath.row == 1){
            
            UILabel *exit = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            exit.text = @"退出当前账号";
            exit.font = FONT(14);
            exit.textAlignment = NSTextAlignmentCenter;
            exit.textColor = kRedColor;
            [cell.contentView addSubview:exit];
        }
        return cell;
        
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
//        if (<#condition#>) {
//            <#statements#>
//        }
        [self didSelectRowAtSection0:indexPath.row];
        
    }else if (indexPath.section == 1){
        
        [self didSelectRowAtSection1:indexPath.row];
        
    }else if (indexPath.section == 2 && indexPath.row == 1){
        
    //退出登录
  
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定退出当前账号?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            HJUser *user = [HJUser sharedUser];
            user.pd.token = @"";
            user.pd.users_id = @"";
            [user write];
            [self updatePersonCenter];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:sureAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}
- (void)updatePersonCenter {

    [self viewDidLoad];
    
}

- (void)didSelectRowAtSection0:(NSInteger )row{
    
    if (row == 0) {
        if (self.isLogin) {
            HXMyAccountInfoVC *vc = [HXMyAccountInfoVC new];
            [self.navigationController pushVC:vc];
            return;
        }
    }else if (row == 1){
        if (self.isLogin) {
            HXMessageVC *vc = [HXMessageVC new];
            [self.navigationController pushVC:vc];
            return;
        }
        
    }else if (row == 2){
        if (self.isLogin) {
        HXMyAttentionSGVC *vc = [HXMyAttentionSGVC new];
        [self.navigationController pushVC:vc];
            return;
            }
    }else if (row == 3){
            if (self.isLogin) {
        HXFriendDynamicStateVC *vc = [HXFriendDynamicStateVC new];
        [self.navigationController pushVC:vc];
            return;
            }
    }
      [self pushLoginVC];
}
- (void)pushLoginVC{

    [self.navigationController pushVC:[HXLoginVC new]];

}
- (void)didSelectRowAtSection1:(NSInteger)row{
    
    if (row == 0) {
        if (self.isLogin) {
        HXBroserRecordSGVC *vc = [HXBroserRecordSGVC new];
        [self.navigationController pushVC:vc];
            return;
            }
    }else if (row == 1){
        
        //分享app
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:platformType];
            
        }];
        
    }else if (row == 2){
        if (self.isLogin) {
        HXAdviceFaceBackVC *vc = [HXAdviceFaceBackVC new];
        [self.navigationController pushVC:vc];
        return;
            }
    }else if (row == 3){
        
        
        return;
    }
    [self pushLoginVC];
    
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
