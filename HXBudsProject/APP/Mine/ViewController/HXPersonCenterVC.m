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
#import "HXMyLikeVC.h"
#import "HXMineLoginHeadView.h"
#import "HXMyAttentionSGVC.h"
#import "HXFriendDynamicStateVC.h"
#import "HXAdviceFaceBackVC.h"
#import "HXBroserRecordSGVC.h"
#import "HXMesssageOneVC.h"
#import <UShareUI/UShareUI.h>
#import "HXIsLoginAPI.h"
#import "HJUser.h"
#import "HXgetUserInfoAPI.h"
#import "HXLoginVC.h"
#import "HXMineLearnCell.h"
#import "HXMyProductVC.h"
#import "HXSetVC.h"
#import "HXPersonInfoVC.h"
#import "HXMapVC.h"


@interface HXPersonCenterVC ()
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
        
        self.mineHeadView.nameLab.text = responseObject[@"pd"][@"nickname"];
        NSString *icostr = responseObject[@"pd"][@"headportrait"];
//        NSLog(@"icostr:%@",kAPIImageFromUrl(icostr));
        if ([icostr containsString:@"https://wx.qlogo.cn"]) {
            [self.mineHeadView.iconImagV sd_setImageWithURL:[NSURL URLWithString:icostr] placeholderImage:[UIImage imageNamed:@"person_ico"]];
        }else{
        [self.mineHeadView.iconImagV sd_setImageWithURL:[NSURL URLWithString:kAPIUserImageFromUrl(icostr)] placeholderImage:[UIImage imageNamed:@"person_ico"]];
        }
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
            HXPersonInfoVC *vc = [HXPersonInfoVC new];
//            HXMyLikeVC *vc = [HXMyLikeVC new];
//            vc.titleStr = @"我的主页";
//            vc.dynamicType = mineDynamicType;
//            HJUser *user = [HJUser sharedUser];
//            vc.users_id = user.pd.users_id;
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
        if (error) {
            self.isLogin = NO;
        }
        CompleteHandle(self.isLogin);
    }];
    
}
- (NSArray *)groupTitles {
    
    return @[@[@" "],@[@"我关注的",@"我收藏的",@"我发布的"],@[@"设置"]];
}

- (NSArray *)groupIcons {
    
  return @[@[@" "],@[@"fo",@"collect_mine",@"sent"],@[@"set"]];
}



- (NSArray *)groupDetials {
    
  return @[@[@" "],@[@" ",@" ",@" "],@[@" "]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
       
        HXMineLearnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXMineLearnCell"];
        if (!cell) {
            cell = [HXMineLearnCell initMineCellWithXib];
        }
        [cell.leftBtn addTarget:self action:@selector(myAccountAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightBtn addTarget:self action:@selector(myMessageAction) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else{
    
        UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 85;
    }
    return 44;
    
}
- (void)myAccountAction {
    
    if (self.isLogin) {
        HXMyAccountInfoVC *vc = [HXMyAccountInfoVC new];
        [self.navigationController pushVC:vc];
        return;
    }
    
        [self pushLoginVC];
    
}
- (void)myMessageAction {
    
    if (self.isLogin) {
        HXMesssageOneVC *vc = [HXMesssageOneVC new];
        [self.navigationController pushVC:vc];
        return;
    }
    [self pushLoginVC];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        [self didSelectRowAtSection1:indexPath.row];
        
    }else if (indexPath.section == 2){
        
      [self.navigationController pushVC:[HXSetVC new]];
    }
}

- (void)updatePersonCenter {

    [self viewDidLoad];
    
}

- (void)didSelectRowAtSection1:(NSInteger )row{
    
    if (row == 0) {
        if (self.isLogin) {
            HXMyAttentionSGVC *vc = [HXMyAttentionSGVC new];
            [self.navigationController pushVC:vc];
            return;
        }
    }else if (row == 1){

        if (self.isLogin) {
        HXBroserRecordSGVC *vc = [HXBroserRecordSGVC new];
        [self.navigationController pushVC:vc];
            return;
            }
        
    }else if (row == 2){
        if (self.isLogin) {
            HXMyProductVC *vc = [HXMyProductVC new];
            [self.navigationController pushVC:vc];
            return;
        }
        
    }
      [self pushLoginVC];
}
- (void)pushLoginVC{

    [self.navigationController pushVC:[HXLoginVC new]];

}

//    else if (row == 1){
//        
//        //分享app
//        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//            
//            // 根据获取的platformType确定所选平台进行下一步操作
//            [self shareWebPageToPlatformType:platformType];
//            
//        }];
//        
//    }else if (row == 2){
//        if (self.isLogin) {
//        HXAdviceFaceBackVC *vc = [HXAdviceFaceBackVC new];
//        [self.navigationController pushVC:vc];
//        return;
//            }
//    }else if (row == 3){
//        
//        
//        return;
//    }
//    [self pushLoginVC];

//

////分享网页链接
//- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
//{
//    
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    
//    //创建网页内容对象
//    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"萌芽-多艺盟" descr:@"艺术教育平台" thumImage:thumbURL];
//    //设置网页地址
//    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
//    
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//    
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        
//        if (error) {
//            UMSocialLogInfo(@"************Share fail with error %@*********",error);
//        }else{
//            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                UMSocialShareResponse *resp = data;
//                //分享结果消息
//                UMSocialLogInfo(@"response message is %@",resp.message);
//                //第三方原始返回的数据
//                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//                
//            }else{
//                UMSocialLogInfo(@"response data is %@",data);
//            }
//        }
//        //        [self alertWithError:error];
//    }];
//}
//
@end
