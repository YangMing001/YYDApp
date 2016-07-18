//
//  NavAnimated.h
//  YYDApp
//
//  Created by YM on 16/7/15.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NavAnimatedType) {
    NavAnimatedTypePush,
    NavAnimatedTypePop
    
};
@interface NavAnimated : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) NavAnimatedType animatedType;

@end
