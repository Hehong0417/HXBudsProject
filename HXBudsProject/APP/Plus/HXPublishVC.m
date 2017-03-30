//
//  HXPublishVC.m
//  HXBudsProject
//
//  Created by n on 2017/3/23.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXPublishVC.h"
#import "TableViewCell.h"
#import "HXCourseDetailCommentCell.h"


@interface HXPublishVC ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,TextViewCellDelegate>

@property(nonatomic,strong) UITableView *tabView;

@property(nonatomic,strong)UILabel *label;

@property (nonatomic,strong) NSMutableArray *data;

@end

@implementation HXPublishVC


//- (void)loadView {

//  UIScrollView  *scrollView = [UIScrollView lh_scrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) contentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT) backgroundColor:kWhiteColor delegate:self];
//    self.view = scrollView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.data = [NSMutableArray arrayWithObjects:@"cell 1", nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabView = [UITableView lh_tableViewWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT - 64) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
//    self.tabView.backgroundColor = kWhiteColor;
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tabView.estimatedRowHeight = 100;
    self.tabView.rowHeight = UITableViewAutomaticDimension;
    [self.tabView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TableViewCell"];
    [self.tabView registerNib:[UINib nibWithNibName:@"HXCourseDetailCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HXCourseDetailCommentCell"];
    
    
    [self.view addSubview:self.tabView];
  
    
    UIView *nav = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) backColor:kWhiteColor];
    [self.view addSubview:nav];
   // nav.hidden = NO;
    XYQButton *cancelBtn = [XYQButton ButtonWithFrame:CGRectMake(20, 24, 60, 40) imgaeName:@"" titleName:@"取消" contentType:LeftTitleRightImage buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kBlackColor fontsize:14] tapAction:^(XYQButton *button) {
        
        //nav.hidden = YES;
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [nav addSubview:cancelBtn];
    
    XYQButton *publishBtn = [XYQButton ButtonWithFrame:CGRectMake(SCREEN_WIDTH - 60, 26, 50, 25) imgaeName:@"" titleName:@"发布" contentType:LeftTitleRightImage buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kLightGrayColor fontsize:14] tapAction:^(XYQButton *button) {
        
        
    }];
    [publishBtn lh_setCornerRadius:3 borderWidth:1 borderColor:kLightGrayColor];
    [nav addSubview:publishBtn];
    
}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
  //  return self.view;
//}
 #pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    if (indexPath.row == 0) {
      
        HXCourseDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HXCourseDetailCommentCell" forIndexPath:indexPath];
        return cell;
        
        }else {
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
        cell.textViewCellDelegate = self;
        cell.textView.text = self.data[0];
        return cell;

    }
    return nil;

}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (indexPath.row == 0) {
//        
//        return 100;
//    }else {
//    
//        return 100;
//    
//    }
//    return 0.01;
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.01;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.01;
//}

- (void)addCoverBtnInCell:(UITableViewCell *)cell{

    
    XYQButton *addCover = [XYQButton ButtonWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 100) imgaeName:@"" titleName:@"十添加封面更有吸引力哦~~" contentType:LeftImageRightTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kLightGrayColor fontsize:14] tapAction:^(XYQButton *button) {
        
        
    }];
    CAShapeLayer *border =  [addCover lh_addStokeLineWithColor:kLightGrayColor lineWidth:1.0f lineCap:@"square" lineDashPattern:@[@4, @2]];
    
    [addCover.layer addSublayer:border];
    
    [cell.contentView addSubview:addCover];
    
    
}
- (void)addTitleTextFieldInCell:(UITableViewCell *)cell{

    
    UITextField *titleTextField = [UITextField lh_textFieldWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) placeholder:@"请输入标题" font:FONT(18) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
    [cell.contentView addSubview:titleTextField];
  
}
- (void)textViewCell:(TableViewCell *)cell didChangeText:(UITextView *)textView
{
    //
    //    UIView *tableView = cell.superview;
    //    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
    //        tableView = tableView.superview;
    //    }
    NSIndexPath *indexPath = [self.tabView indexPathForCell:cell];
    NSMutableArray *data = [self.data mutableCopy];
    data[indexPath.row] = textView.text;
    self.data = [data copy];
}

//- (void)addContentTextViewInCell:(UITableViewCell *)cell{
//    
//    UITextView *contentTextView = [UITextView lh_textViewWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 200) font:FONT(18) backgroundColor:kWhiteColor];
//    contentTextView.text = @"输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容输入内容";
//    contentTextView.showsVerticalScrollIndicator = NO;
//    contentTextView.scrollEnabled = NO;
//    [cell.contentView addSubview:contentTextView];
//    
//}
@end
