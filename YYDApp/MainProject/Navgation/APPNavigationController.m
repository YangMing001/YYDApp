//
//  APPNavigationController.m
//  YYDApp
//
//  Created by YM on 16/7/14.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "APPNavigationController.h"
#import "NavAnimated.h"
#import "UIColor+AppColor.h"

@interface APPNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic,strong) NavAnimated *navAnimate;
@end

@implementation APPNavigationController

+ (void)initialize{
    
    // 1.appearance方法返回一个导航栏的外观对象
    //修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    [navigationBar setBarTintColor:[UIColor navBarBackgroundColor]];
    [navigationBar setTintColor:[UIColor whiteColor]];// iOS7的情况下,设置NavigationBarItem文字的颜色
    // 3.设置导航栏文字的主题
    NSShadow *shadow = [[NSShadow alloc]init];
    [shadow setShadowOffset:CGSizeZero];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                            NSShadowAttributeName : shadow}];
    //    [navigationBar setBackgroundImage:[UIImage imageNamed:@"ic_cell_bg_selected"] forBarMetrics:UIBarMetricsDefault];
    // 4.修改所有UIBarButtonItem的外观
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    
    [barButtonItem setTintColor:[UIColor whiteColor]];
    
    // 5.设置状态栏样式
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
}


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
//        self.delegate = self;
    }
    return self;
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if ( self.viewControllers.count >0) {
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];

}
-(UIBarButtonItem *)creatBackButton
{
//    return [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backbtn"]style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    return [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
}
-(void)popSelf
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - Delegate
#pragma mark - Setter And Getter

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    
    switch (operation) {
        case  UINavigationControllerOperationPush:
        {
            self.navAnimate.animatedType = NavAnimatedTypePush;
            return self.navAnimate;
        }
            break;
            
        case  UINavigationControllerOperationPop:
        {
            self.navAnimate.animatedType = NavAnimatedTypePop;
            return self.navAnimate;
        }
            break;
          
        default:
            break;
    }
    return nil;
}

- (NavAnimated *)navAnimate{
    if (!_navAnimate) {
        _navAnimate = [NavAnimated new];
    }
    return _navAnimate;
}


@end
