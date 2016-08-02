//
//  CutDownButton.h
//  YYDApp
//
//  Created by YM on 16/8/1.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa.h>

@interface CutDownButton : UIButton

/**倒计时数*/
@property (nonatomic,assign) NSInteger timeInterval;


@property (nonatomic,assign) RACSignal *commodSignal;


@end
