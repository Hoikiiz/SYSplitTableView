//
//  CategoryTableView.h
//  SplitTableViewDemo
//
//  Created by SunYang on 16/8/25.
//  Copyright © 2016年 SunYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplitTableView.h"

@protocol CategoryTableViewDelegate <NSObject>

- (NSArray *)needDataFor:(NSIndexPath *)indexPath;
@optional
- (void)didSelectDetailAt:(NSInteger)indexPathRow;

@end

@interface CategoryTableView : UIView
@property (strong, nonatomic) SplitTableView *mainTableView;
@property (copy, nonatomic) NSArray *masterDataSource;
@property (copy, nonatomic) NSArray *masterSectionDataSource;
@property (copy, nonatomic) NSArray *currentDetailDataSource;
@property (strong, nonatomic) NSMutableDictionary *cacheData;
@property (weak, nonatomic) id<CategoryTableViewDelegate>delegate;
@property (assign, nonatomic) BOOL isItem;
- (void)reload;

@end
