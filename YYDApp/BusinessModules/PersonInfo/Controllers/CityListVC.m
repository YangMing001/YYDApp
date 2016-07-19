//
//  CityListVC.m
//  YYDApp
//
//  Created by YM on 16/7/18.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "CityListVC.h"
#import "CityListViewModel.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import <ReactiveCocoa.h>

#import "ErrorMessageReformer.h"

@interface CityListVC ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) CityListViewModel *cityListVM;


@end

@implementation CityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    [self layoutUI];
    [self prepareAction];
}

#pragma mark Private
- (void)prepareUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)layoutUI{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)prepareAction{
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.cityListVM refresh];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.cityListVM loadMore];
    }];
    
    self.cityListVM.cityAPIManager.delegate = self;
}

#pragma mark DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cityListVM.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"CELL"];
    }
    return cell;
}


- (void)apiManagerCallBackDidSuccess:(BaseAPIManager *)manager{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}
- (void)apiManagerCallBackDidFailed:(BaseAPIManager *)manager{
    NSLog(@"%@",[manager fetchDataWithReformer:[ErrorMessageReformer new]]);
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - Getter and Setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _tableView.delegate     = self;
        _tableView.dataSource   = self;
    }
    return _tableView;
}

-(CityListViewModel *)cityListVM{
    if (!_cityListVM) {
        _cityListVM = [CityListViewModel new];
    }
    return _cityListVM;
}


@end
