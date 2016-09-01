//
//  SplitTableView.m
//  SplitTableViewDemo
//
//  Created by SunYang on 16/8/24.
//  Copyright © 2016年 SunYang. All rights reserved.
//

#import "SplitTableView.h"

@interface SplitTableView()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@end

@implementation SplitTableView

- (instancetype)initWithFrame:(CGRect)frame MasterWidth:(CGFloat)width dataSource:(id<SplitTableViewDataSource>)dataSource delegate:(id<SplitTableViewDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {
        self.masterTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.masterTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
//        self.detailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.detailCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.detailCollectionView.backgroundColor = [UIColor whiteColor];
        self.detailCollectionView.delegate = self;
        self.detailCollectionView.dataSource = self;
        self.masterTableView.delegate = self;
        self.masterTableView.dataSource = self;
//        self.detailTableView.delegate = self;
//        self.detailTableView.dataSource = self;
        [self addSubview:self.masterTableView];
        [self addSubview:self.detailCollectionView];
//        [self addSubview:self.detailTableView];
        self.dataSource = dataSource;
        self.delegate = delegate;
        self.masterWidth = width;
    }
    return self;
}

- (void)layoutSubviews {
    self.masterTableView.frame = CGRectMake(0, 0, self.masterWidth, self.frame.size.height);
    self.detailCollectionView.frame = CGRectMake(self.masterWidth, 0, self.frame.size.width - self.masterWidth, self.frame.size.height);
}



- (void)reload {
    [self.masterTableView reloadData];
    [self.detailCollectionView reloadData];
}

- (void)reloadDetail {
    [self.detailCollectionView reloadData];
}








#pragma mark - CollectionView

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        return [self.delegate collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
    } else {
        return UIEdgeInsetsZero;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(sender:didSelectRowAtIndexPath:)]) {
        [self.delegate sender:collectionView didSelectRowAtIndexPath:indexPath];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(collectionView:sizeForItemAtIndexPath:)]) {
        return [self.delegate collectionView:collectionView sizeForItemAtIndexPath:indexPath];
    } else {
        return CGSizeZero;
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(sender:numberOfRowsInSection:)]) {
        return [self.dataSource sender:collectionView numberOfRowsInSection:section];
    } else {
        return 0;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(sender:cellForRowAtIndexPath:)]) {
        return [self.dataSource sender:collectionView cellForRowAtIndexPath:indexPath];
    } else {
        return [UICollectionViewCell new];
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1f;
}

#pragma mark - TableView

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.delegate tableView:tableView viewForHeaderInSection:section];
    } else {
        return [UIView new];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.delegate tableView:tableView heightForHeaderInSection:section];
    } else {
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(sender:didSelectRowAtIndexPath:)]) {
        [self.delegate sender:tableView didSelectRowAtIndexPath:indexPath];
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return [self.dataSource tableView:tableView titleForHeaderInSection:section];
    } else {
        return nil;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.dataSource numberOfSectionsInTableView:tableView];
    } else {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(sender:numberOfRowsInSection:)]) {
        return [self.dataSource sender:tableView numberOfRowsInSection:section];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(sender:cellForRowAtIndexPath:)]) {
        return [self.dataSource sender:tableView cellForRowAtIndexPath:indexPath];
    } else {
        return [UITableViewCell new];
    }
    
}

@end
