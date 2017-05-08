//
//  HXteacherList.m
//  HXBudsProject
//
//  Created by n on 2017/4/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXteacherList.h"
#import "HXTeacherCollectionCell.h"
#import "HXMyLikeVC.h"
#import "HXTeacherListAPI.h"
#import "HXIsLoginAPI.h"
#import "HXFollowAPI.h"
#import "HXIsLoginAPI.h"
#import "HXLoginVC.h"

@interface HXteacherList ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{

  BOOL isLogin;
}
@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic, strong) HXTeacherListModel *teacherListModel;

@end

@implementation HXteacherList

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self getTeacherList];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"名师推荐";
    
    UICollectionViewFlowLayout *flowout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 ) collectionViewLayout:flowout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = kWhiteColor;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HXTeacherCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HXTeacherCollectionCell"];
    self.view.backgroundColor = kWhiteColor;

}

- (void)getTeacherList{
    
    //判断是否登录
    HJUser *user = [HJUser sharedUser];
    [[[HXIsLoginAPI isLoginWithToken:user.pd.token] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        
        NSString *isLoginStr = responseObject[@"pd"][@"islogin"];
        if ([isLoginStr isEqualToString:@"no"]) {
            isLogin = NO;
        }else {
            isLogin = YES;
        }
        
        [[[HXTeacherListAPI getTeacherListWithWithLimit:@10 isLogin:isLogin] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
            
            HXTeacherListModel *api = [HXTeacherListModel new];
            
            self.teacherListModel = [api.class mj_objectWithKeyValues:responseObject];
            
            [self.collectionView reloadData];
            
        }];
        
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
        HXTeacherCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXTeacherCollectionCell" forIndexPath:indexPath];
        cell.teacherModel = self.teacherListModel.varList[indexPath.row];
      cell.followSelectedBlock = ^(BOOL followed) {
        if (isLogin) {
            [self followRequest:indexPath.row followed:followed];
        }else {
            
            [self.navigationController pushVC:[HXLoginVC new]];
        }
    };
        return cell;
}
- (void)followRequest:(NSInteger )row followed:(BOOL)followed{
    
    
    HXteacherVarListModel *model = self.teacherListModel.varList[row];
    
    [[[HXFollowAPI followTeacherWiththeteacherId:model.theteacher_id state:followed?@"1":@"0"] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
    }];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
        
        return self.teacherListModel.varList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        
        return CGSizeMake(SCREEN_WIDTH , 100);
        
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
        HXMyLikeVC *vc = [HXMyLikeVC new];
        HXteacherVarListModel *model = self.teacherListModel.varList[indexPath.row];
        vc.theteacher_id = model.theteacher_id;;
        vc.titleStr = @"他的主页";
        vc.dynamicType = teacherDynamicType;
        [self.navigationController pushVC:vc];
    
}


@end