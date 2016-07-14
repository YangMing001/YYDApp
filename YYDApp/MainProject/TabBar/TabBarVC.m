//
//  TabBarVC.m
//  YYDApp
//
//  Created by YM on 16/7/14.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "TabBarVC.h"
#import "TabBarHelper.h"

#import "TabBarView.h"
#import <ReactiveCocoa.h>
@interface TabBarVC ()<TabBarViewDelegate>

@property (nonatomic,strong)TabBarView *barView;

@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self prepareControllers];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBar bringSubviewToFront:self.barView];

}

#pragma mark - Private Method
- (void)configUI{
    [self.tabBar addSubview:self.barView];
}

- (void)prepareControllers{
    self.viewControllers = [TabBarHelper defautlControllers];
}

#pragma mark - Delegate 
- (void)tabbarView:(TabBarView *)tabbarView selectedIndex:(NSInteger)index{
    self.selectedIndex = index;
}

#pragma mark - Getter and Setter
- (TabBarView *)barView{
    if (!_barView) {
        _barView = [[TabBarView alloc] initWithFrame:self.tabBar.bounds];
        _barView.backgroundColor = [UIColor yellowColor];
        _barView.delegate = self;
        [_barView configTabbarWithImages:[TabBarHelper tabbarNormalAndSelectedImages]];
    }
    return _barView;
}

@end
