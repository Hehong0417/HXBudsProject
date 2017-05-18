//
//  HXCurriSearchVC.m
//  HXBudsProject
//
//  Created by n on 2017/5/15.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCurriSearchVC.h"
#import "HXTeachingTypeListModel.h"
#import "HXTeachingTypeListAPI.h"
#import "HXCurriculumSearchAPI.h"
#import "HXSubjectVideoListModel.h"

#define  Margin 10
@interface HXCurriSearchVC ()<UISearchBarDelegate>
@property (nonatomic, strong) HXTeachingTypeListModel *teachingTypeListModel;
@property (nonatomic, strong) HXSubjectVideoListModel *searchVideoModel;


@end

@implementation HXCurriSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getTeachingTypeList];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelDidClick)];
    
    // 创建搜索框
    UIView *titleView = [[UIView alloc] init];
    titleView.mj_x = Margin * 0.5;
    titleView.mj_y = 7;
    titleView.mj_w = self.view.mj_w - 64 - titleView.mj_x * 2;
    titleView.mj_h = 30;
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:titleView.bounds];
    searchBar.mj_w -= Margin * 1.5;
    searchBar.placeholder = @"搜索";
    searchBar.backgroundImage = [UIImage imageNamed:@"search_box"];
    [searchBar lh_setCornerRadius:3 borderWidth:1 borderColor:LineLightColor];
    //    searchBar.delegate = self;
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    self.navigationItem.titleView = titleView;
    self.navigationItem.hidesBackButton = YES;
    // 设置头部（热门搜索）
    UIView *contentView = [[UIView alloc] init];
    contentView.mj_y = Margin * 2;
    contentView.mj_x = Margin * 1.5;
    contentView.mj_w = SCREEN_WIDTH - contentView.mj_x * 2;
    contentView.mj_h = SCREEN_HEIGHT;
    UILabel *titleLabel = [self setupTitleLabel:@"大家都在看"];
    [contentView addSubview:titleLabel];
    [self.view addSubview:contentView];
    //标签容器
    UIView *tagcontentView = [[UIView alloc] init];
    tagcontentView.mj_y = titleLabel.mj_y+15;
    tagcontentView.mj_x = 10;
    tagcontentView.mj_w = contentView.mj_w - contentView.mj_x * 2;
    [contentView addSubview:tagcontentView];
    
    [self addTagBtnWithTagcontentView:tagcontentView];

}

- (void)getTeachingTypeList{
    
    [[[HXTeachingTypeListAPI getTeachingTypeList] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        HXTeachingTypeListModel *api = [HXTeachingTypeListModel new];
        self.teachingTypeListModel = [api.class mj_objectWithKeyValues:responseObject];
        
    }];
    
}
- (void)addTagBtnWithTagcontentView:(UIView *)tagcontentView{

    float butX = 15;
    float butY = 10;
    
    for(int i = 0; i < self.teachingTypeListModel.varList.count; i++){
        //宽度自适应
        HXTeachingTypeVarListModel *model = self.teachingTypeListModel.varList[i];
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        CGRect frame_W = [model.type_name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        
        if (butX+frame_W.size.width+20 > SCREEN_WIDTH-15) {
            
            butX = 15;
            
            butY += 45;
        }
        
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+20, 30)];
        but.backgroundColor = kWhiteColor;
        [but setTitle:model.type_name forState:UIControlStateNormal];
        [but setTitleColor:APP_COMMON_COLOR forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13];
        but.layer.cornerRadius = 8;
        but.layer.borderColor = APP_COMMON_COLOR.CGColor;
        but.layer.borderWidth = 1;
        but.tag = i+1;
        [but setTapActionWithBlock:^{
            

            
            
        }];
        [tagcontentView addSubview:but];
        
        butX = CGRectGetMaxX(but.frame)+10;
    }
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
//   根据输入文本显示建议搜索结果
    self.searchResultVC.view.hidden = self.searchSuggestionHidden || !searchText.length;
    
    //标题模糊查询
    [[[HXCurriculumSearchAPI getsearchCurriculumListWithCurr_title:searchText teachingtype_id:nil]netWorkClient]postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        HXSubjectVideoListModel *api = [HXSubjectVideoListModel new];
        self.searchVideoModel = [api.class mj_objectWithKeyValues:responseObject];
        
    }];
    
    
    // 放在最上层
    [self.view bringSubviewToFront:self.searchResultVC.view];
    
//    // 如果代理实现了代理方法则调用代理方法
//    if ([self.delegate respondsToSelector:@selector(searchViewController:searchTextDidChange:searchText:)]) {
//        [self.delegate searchViewController:self searchTextDidChange:searchBar searchText:searchText];
//    }
}


/** 创建并设置标题 */
- (UILabel *)setupTitleLabel:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.tag = 1;
    titleLabel.textColor = kGrayColor;
    [titleLabel sizeToFit];
    titleLabel.mj_x = 0;
    titleLabel.mj_y = 0;
    return titleLabel;
}
/** 点击取消 */
- (void)cancelDidClick
{
    [self.searchBar resignFirstResponder];
    
    // dismiss ViewController
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [self.navigationController popVC];
    
    //    // 调用代理方法
    //    if ([self.delegate respondsToSelector:@selector(didClickCancel:)]) {
    //        [self.delegate didClickCancel:self];
    //    }
}
- (HXCurriSearchResultVC *)searchResultVC {

    if (!_searchResultVC) {
        _searchResultVC = [[HXCurriSearchResultVC alloc]init];
        [self addChildViewController:_searchResultVC];
    }
    return _searchResultVC;
}
@end
