//
//  TabBarView.h
//  YYDApp
//
//  Created by YM on 16/7/14.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBarView;
@protocol TabBarViewDelegate <NSObject>

- (void)tabbarView:(TabBarView *)tabbarView selectedIndex:(NSInteger)index;

@end

@interface TabBarView : UIView

@property (nonatomic,weak) UIViewController<TabBarViewDelegate> *delegate;

- (void)configTabbarWithImages:(NSArray *)imagesArray;

@end
