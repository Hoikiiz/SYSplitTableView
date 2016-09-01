//
//  SplitTableView.h
//  SplitTableViewDemo
//
//  Created by SunYang on 16/8/24.
//  Copyright © 2016年 SunYang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SplitTableViewDelegate <UITableViewDelegate>
- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)sender:(id)sender didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
@end

@protocol SplitTableViewDataSource <UITableViewDataSource>
- (NSInteger)sender:(id)sender numberOfRowsInSection:(NSInteger)section;
- (id)sender:(id)sender cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface SplitTableView : UIView

@property (strong, nonatomic) UITableView *masterTableView;
//@property (strong, nonatomic) UITableView *detailTableView;
@property (strong, nonatomic) UICollectionView *detailCollectionView;

@property (weak, nonatomic) id<SplitTableViewDelegate>delegate;
@property (weak, nonatomic) id<SplitTableViewDataSource>dataSource;

@property (assign, nonatomic) CGFloat masterWidth;

- (instancetype)initWithFrame:(CGRect)frame MasterWidth:(CGFloat)width dataSource:(id<SplitTableViewDataSource>)dataSource delegate:(id<SplitTableViewDelegate>)delegate;

- (void)reload;
- (void)reloadDetail;

@end
