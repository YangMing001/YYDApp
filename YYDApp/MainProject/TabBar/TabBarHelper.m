//
//  TabBarHelper.m
//  YYDApp
//
//  Created by YM on 16/7/14.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "TabBarHelper.h"
#import "APPNavigationController.h"
#import "YMMediator+PersonActions.h"
#import "TabBarDefine.h"
#import "UtilsMacro.h"
@implementation TabBarHelper

+ (NSArray<UIViewController *> *)defautlControllers{
    UIViewController *personVC = [[YMMediator sharedInstance] MediatorViewControllerForPersonVC];
    APPNavigationController *navPresonVC = [[APPNavigationController alloc] initWithRootViewController:personVC];
    
    return @[navPresonVC,navPresonVC];
  
}
+ (NSArray<NSDictionary *> *)tabbarNormalAndSelectedImages{
    NSDictionary *personImages = @{kSelectedImage :[UIImage imageNamed:@"tab_Mine_P"],
                                   kUnSelectedImage:[UIImage imageNamed:@"tab_Mine"]
                                   };
    
    
    return @[personImages,personImages];

}



@end
