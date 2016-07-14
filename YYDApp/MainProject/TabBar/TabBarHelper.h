//
//  TabBarHelper.h
//  YYDApp
//
//  Created by YM on 16/7/14.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TabBarHelper : NSObject


/**
 *  TabBar 的 子 Controllers
 *
 *  @return 被TabbarVC 直接使用的 Controllers
 */
+ (NSArray<UIViewController *> *)defautlControllers;



/**
 *  获取tabbarController底部tabbar的图片配置
 *
 *  @return 含有选中图片和未选中图片的数组
 */
+ (NSArray<NSDictionary *> *)tabbarNormalAndSelectedImages;

@end
