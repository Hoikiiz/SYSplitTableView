//
//  CategoryTableView.m
//  SplitTableViewDemo
//
//  Created by SunYang on 16/8/25.
//  Copyright © 2016年 SunYang. All rights reserved.
//

#import "CategoryTableView.h"

@interface CategoryTableView()<SplitTableViewDelegate,SplitTableViewDataSource>
//@property (strong, nonatomic) UITableView *bottomTableView;
@end

@implementation CategoryTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mainTableView = [[SplitTableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) MasterWidth:frame.size.width / 2.0 dataSource:self delegate:self];
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.mainTableView.detailCollectionView.collectionViewLayout;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 20;
        [self addSubview:self.mainTableView];
        self.cacheData = [NSMutableDictionary dictionary];
//        self.bottomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.frame.size.width, self.frame.size.height - 64) style:UITableViewStylePlain];
//        [self insertSubview:self.bottomTableView atIndex:0];
//        self.bottomTableView.delegate = self;
//        self.bottomTableView.dataSource = self;
    }
    return self;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 10;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@""];
//    cell.textLabel.text = @"Cell";
//    return cell;
//}


- (void)layoutSubviews {
    self.mainTableView.frame = self.bounds;
    self.mainTableView.masterWidth = self.frame.size.width * 0.4f;
}

- (void)reload {
    [self.mainTableView reload];
}

#pragma mark - SplitTableViewDataSource

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (_isItem) {
        return UIEdgeInsetsMake(5, 5, 5, 5);
    } else {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_isItem) {
        return CGSizeMake(70, 100);
    } else {
        return CGSizeMake(self.frame.size.width * 0.6f - 6, 44);
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.mainTableView.masterTableView) {
        return self.masterDataSource.count;
    } else {
        return 1;
    }
}

- (void)sender:(id)sender didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"deselect");
}

- (NSInteger)sender:(id)sender numberOfRowsInSection:(NSInteger)section {
    if (sender == self.mainTableView.masterTableView) {
        return [self.masterDataSource[section] count];
    }
    if (sender == self.mainTableView.detailCollectionView) {
        return self.currentDetailDataSource.count;
    }
    return 0;
}


- (id)sender:(id)sender cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (sender == self.mainTableView.masterTableView) {
        return [self masterTableView:sender cellForRowAtIndexPath:indexPath];
    } else if (sender == self.mainTableView.detailCollectionView) {
        return [self detailCollectionView:sender itemForRowAtIndexPath:indexPath];
    } else {
        return nil;
    }
}


- (UITableViewCell *)masterTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"masterTableView"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"masterTableView"];
    }
    cell.textLabel.text = [self.masterDataSource[indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}

- (UICollectionViewCell *)detailCollectionView:(UICollectionView *)collectionView itemForRowAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"detailCollectionView"];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailCollectionView" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    if (_isItem) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 60, 60)];
        view.layer.cornerRadius = 4;
        view.backgroundColor = [UIColor orangeColor];
        [cell.contentView addSubview:view];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 60, 20)];
        label.text = self.currentDetailDataSource[indexPath.item];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:8];
        [cell.contentView addSubview:label];
        cell.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
        label.text = self.currentDetailDataSource[indexPath.item];
        [cell.contentView addSubview:label];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, cell.frame.size.width, 1)];
        line.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.90 alpha:1.00];
        [cell.contentView addSubview:line];
    }
    
    return cell;
}


#pragma mark - SplitTableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.mainTableView.masterTableView) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.mainTableView.masterWidth, 50)];
        lab.backgroundColor = [UIColor lightGrayColor];
        lab.text = self.masterSectionDataSource[section];
        lab.textAlignment = NSTextAlignmentCenter;
        return lab;
    } else {
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (tableView == self.mainTableView.masterTableView) {
//        return self.masterSectionDataSource[section];
//    } else {
//        return nil;
//    }
//}

- (void)sender:(id)sender didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (sender == self.mainTableView.masterTableView) {
        
        NSString *key = [NSString stringWithFormat:@"%lu-%lu",indexPath.section,indexPath.row];
        for (NSString *k in self.cacheData.allKeys) {
            if ([k isEqualToString:key]) {
                self.currentDetailDataSource = self.cacheData[k];
                [self.mainTableView reloadDetail];
            }
        }
        self.currentDetailDataSource = [self.delegate needDataFor:indexPath];
        [self.mainTableView reloadDetail];
        [self.cacheData setValue:self.currentDetailDataSource forKey:key];
        
        
    } else if (sender == self.mainTableView.detailCollectionView) {
        if ([self.delegate respondsToSelector:@selector(didSelectDetailAt:)]) {
            [self.delegate didSelectDetailAt:indexPath.row];
        }
    }
}




















@end
