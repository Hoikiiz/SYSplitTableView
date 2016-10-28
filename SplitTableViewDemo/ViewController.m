//
//  ViewController.m
//  SplitTableViewDemo
//
//  Created by SunYang on 16/8/24.
//  Copyright © 2016年 SunYang. All rights reserved.
//

#import "ViewController.h"
#import "CategoryTableView.h"


@interface ViewController ()<CategoryTableViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIButton *showBtn;
@property (strong, nonatomic) CategoryTableView *tableView;
@property (strong, nonatomic) NSArray *masterData;
@property (strong, nonatomic) NSArray *masterSection;
@property (strong, nonatomic) NSArray *currentArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    self.showBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.showBtn setTitle:@"药品分类" forState:UIControlStateNormal];
    self.showBtn.frame = CGRectMake(0, 64, 375, 40);
    [self.showBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showBtn];
    
    self.tableView = [[CategoryTableView alloc] initWithFrame:CGRectMake(0, 104, 375, 300)];
    [self.view addSubview:self.tableView];
    self.tableView.masterDataSource = self.masterData;
    self.tableView.masterSectionDataSource = self.masterSection;
    self.tableView.currentDetailDataSource = self.currentArray;
    self.tableView.delegate = self;
    [self.tableView reload];
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Change" style:UIBarButtonItemStyleDone target:self action:@selector(bbiClick)];
    self.navigationItem.rightBarButtonItem = bbi;
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}



- (void)bbiClick {
    self.tableView.isItem = !self.tableView.isItem;
    [self.tableView reload];
}

- (void)loadData {
    NSMutableArray *header = [NSMutableArray array];
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        NSMutableArray *temp2 = [NSMutableArray array];
        NSString *first = [NSString stringWithFormat:@"一级品类%d",i +1];
        [header addObject:first];
        for (int j = 0; j < 5; j ++) {
            NSString *second = [NSString stringWithFormat:@"二级品类%d",j +1];
            [temp2 addObject:second];
        }
        [temp addObject:[temp2 copy]];
    }
    self.masterData = [temp copy];
    self.masterSection = [header copy];
    [self randomDetail];
}

- (NSArray *)randomDetail {
    NSMutableArray *temp = [NSMutableArray array];
    int count = arc4random()%20 + 1;
    for (int i = 0; i < count; i ++) {
        NSString *str = [NSString stringWithFormat:@"Data %u",arc4random()%1000];
        [temp addObject:str];
    }
    sleep(0.5);
    self.currentArray = [temp copy];
    return self.currentArray;
}


- (void)btnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    btn.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.userInteractionEnabled = YES;
    });
    [UIView animateWithDuration:.35f animations:^{
        if (btn.selected) {
            self.tableView.transform = CGAffineTransformMakeTranslation(0, -500);
        } else {
            self.tableView.transform = CGAffineTransformIdentity;
        }
    }];
}

#pragma mark - CategoryTableViewDelegate

- (NSArray *)needDataFor:(NSIndexPath *)indexPath {
    return [self randomDetail];
}

- (void)didSelectDetailAt:(NSInteger)indexPathRow {
    NSLog(@"%@",self.currentArray[indexPathRow]);
}










@end
