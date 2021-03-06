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
#import "UIView+WHC_AutoLayout.h"
#import "HXHomeInfoArtcleAPI.h"
#import "HXHomeInfoArticleModel.h"
#import "HXArticleTypeAPI.h"
#import "HXArticleTypeModel.h"
#import "HXtestWebView.h"


@interface HXArticleVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tabView;

@property(nonatomic,strong)NSMutableArray *subjectArr;

@property(nonatomic,assign)BOOL isViewMore;
@property(nonatomic,strong)HXHomeInfoArticleModel *articleModel;
@property(nonatomic,strong)HXArticleTypeModel *articleTypeModel;
@property(nonatomic,assign)NSInteger page;
@property (nonatomic, strong) NSMutableArray *GroupArr;
@property (nonatomic, strong) MJRefreshNormalHeader *refreshHeader;


@end

@implementation HXArticleVC

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.page = 1;
    
    [self.tabView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabView = [UITableView lh_tableViewWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabView];
    self.tabView.showsVerticalScrollIndicator = NO;
    
    [self.tabView registerClass:[HXArticleCellOne class] forCellReuseIdentifier:@"HXArticleCellOne"];
    self.tabView.backgroundColor = kWhiteColor;
    self.view.backgroundColor = kWhiteColor;
    [self addHeaderRefresh];
    [self addFooterRefresh];
    
}
- (void)addHeaderRefresh{
    [self.GroupArr removeAllObjects];
    self.refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getArticleTypeList];
        [self getArticleListData];
    }];
    self.tabView.mj_header = self.refreshHeader;
    
}

- (void)addFooterRefresh {
    
    MJRefreshAutoNormalFooter  *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getArticleListData];
        
    }];
    
    self.tabView.mj_footer = refreshFooter;
    
    
}

- (void)getArticleListData {
    
    [self.GroupArr removeAllObjects];

    [[[HXHomeInfoArtcleAPI getHomeInfoArticleWithTheteacherId:nil mechanism_id:nil limit:@(5*self.page)] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        if (error==nil) {
            
            HXHomeInfoArticleModel *api = [HXHomeInfoArticleModel new];
            
            self.articleModel = [api.class mj_objectWithKeyValues:responseObject];
            
            [self loadDataFinish:self.articleModel.varList];

        }
        
    }];

}
/**
 *  加载数据完成
 */
- (void)loadDataFinish:(NSArray *)arr {
    
    // 添加数据
    if (self.page > 1) {
        
        [self.GroupArr addObjectsFromArray:arr];
    } else {
        
        self.GroupArr = arr.mutableCopy;
    }
    
//    // 判断还有没有数据
//    if (arr.count == 0) {
//        
//        [SVProgressHUD showInfoWithStatus:@"暂无更多数据"];
//    }
    
    BOOL noMoreData = (arr.count == 0 || arr.count < KpageSize);
    
    
    [self endRefreshing:noMoreData];
}

/**
 *  结束刷新
 */
- (void)endRefreshing:(BOOL)noMoreData {
    // 取消刷新
    if (self.tabView.mj_header.isRefreshing) {
        [self.tabView.mj_header endRefreshing];
    }
    else if (self.tabView.mj_footer.isRefreshing) {
        [self.tabView.mj_footer endRefreshing];
    }
    // 数据重载
    [self.tabView reloadData];
    
}

- (void)getArticleTypeList {

     [[[HXArticleTypeAPI getArticleTypeList] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        if (error==nil) {
         HXArticleTypeModel *api = [HXArticleTypeModel new];
         self.articleTypeModel = [api.class mj_objectWithKeyValues:responseObject];

         [self.tabView reloadData];
        }
     }];

}

#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HXArticleCellOne *cell = [tableView dequeueReusableCellWithIdentifier:@"HXArticleCellOne"];

        [cell setSubjectArr:self.articleTypeModel.varList isViewMore:self.isViewMore cellHeight:90];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.vc = self.navigationController;
        return cell;
        
    }else{
    HXArticleCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:@"HXArticleCellTwo"];
    if (!cell) {
        
        cell = [HXArticleCellTwo initArticleCellTwoWithXib];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.articleType = homeArticle;
        if (self.GroupArr.count>0) {
            cell.model = self.GroupArr[indexPath.row];
        }
    cell.nav = self.navigationController;
    return cell;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else{
        return self.GroupArr.count;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 1) {
        
        return nil;
    }
    UIView *footView  = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10) backColor:kWhiteColor];
    //按钮与线的间距10 与屏幕的间距为15
//    UIView *leftLine = [UIView lh_viewWithFrame:CGRectMake(10, 8,SCREEN_WIDTH - 20 , 1) backColor:LineDeepColor];
    
//    UIView *leftLine = [UIView lh_viewWithFrame:CGRectMake(15, 8,(SCREEN_WIDTH - 100)/2 , 1) backColor:LineDeepColor];
//    
//    XYQButton *moreBtn = [XYQButton ButtonWithFrame:CGRectMake(15+leftLine.width+5, 5, 58, 10) imgaeName:@"down" titleName:@"查看更多" contentType:LeftImageRightTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:LineDeepColor fontsize:10] tapAction:^(XYQButton *button) {
//        
//        self.isViewMore = !self.isViewMore;
//        [self.tabView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
//        
//    }];
//    UIView *rightLine = [UIView lh_viewWithFrame:CGRectMake(SCREEN_WIDTH - 15 - leftLine.width, 8, leftLine.width, 1) backColor:LineDeepColor];
//    [footView addSubview:leftLine];
//    [footView addSubview:rightLine];
//    [footView addSubview:moreBtn];
    return footView;
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
        
//        if (self.isViewMore) {
//            
//            return [self calculteCellHeightWithSubjectArr];
//            
//        }else {
        
            CGFloat height = [HXArticleCellOne whc_CellHeightForIndexPath:indexPath tableView:tableView];
            return height;
            
//        }
    }else{
        
        CGFloat height = [HXArticleCellTwo whc_CellHeightForIndexPath:indexPath tableView:tableView];
        return height;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return WidthScaleSize_H(40);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        return 10;
    }else{
        
        return 0.01;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        HXArticleDetailVC *vc = [HXArticleDetailVC new];
        vc.articleModel = self.articleModel.varList[indexPath.row];
        [self.navigationController pushVC:vc];
    }
}

- (CGFloat)calculteCellHeightWithSubjectArr{
    
    CGFloat cellHeight = 0.0;
    float butX = 15;
    float butY = 10 ;
    
    for(int i = 0; i < self.subjectArr.count; i++){
        
        //宽度自适应
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        CGRect frame_W = [self.subjectArr[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        
        if (butX+frame_W.size.width+20 > SCREEN_WIDTH-15) {
            
            butX = 15;
            
            butY += 45;
        }
        
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+20, 30)];
        [but setTitle:self.subjectArr[i] forState:UIControlStateNormal];
        [but setTitleColor:APP_COMMON_COLOR forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13];
        but.layer.cornerRadius = 8;
        but.layer.borderColor = APP_COMMON_COLOR.CGColor;
        but.layer.borderWidth = 1;
        but.tag = i+1;
        
        if (i == self.subjectArr.count -1 ) {
            
            cellHeight = butY +45 ;
            
        }
        butX = CGRectGetMaxX(but.frame)+10;
        
    }
    
    return cellHeight;
}

- (NSMutableArray *)subjectArr {
    
    if (!_subjectArr) {
        
        _subjectArr = [NSMutableArray array];
    }
    return _subjectArr;
}
#pragma mark - Setter_Getter
- (NSMutableArray *)GroupArr {
    if (!_GroupArr) {
        _GroupArr = [NSMutableArray array];
    }
    return _GroupArr;
}
@end
