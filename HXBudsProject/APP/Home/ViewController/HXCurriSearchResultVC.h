//
//  HXCurriSearchResultVC.h
//  HXBudsProject
//
//  Created by n on 2017/5/15.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CurriSearchResultDelegate <NSObject>



@end
@protocol CurriSearchResultDataSource <NSObject>

- (NSInteger)CurriSearchResultTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)CurriSearchResultTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HXCurriSearchResultVC : UIViewController

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,copy) id <CurriSearchResultDelegate> delegate;

@property(nonatomic,copy) id <CurriSearchResultDataSource> dataSource;

@end
