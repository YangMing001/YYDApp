//
//  CutDownButton.m
//  YYDApp
//
//  Created by YM on 16/8/1.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "CutDownButton.h"

@implementation CutDownButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType{
    CutDownButton *btn = [super buttonWithType:buttonType];
    [[[[btn rac_signalForControlEvents:UIControlEventTouchUpInside]
       flattenMap:^id(id value) {
           return [btn retryButtonTitleAndEnable];
       }]
      
      takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(RACTuple *tuple) {
         NSString *title = tuple.first;
         [btn setTitle:title forState:(UIControlStateNormal)];
         btn.enabled = ((NSNumber *)tuple.second).boolValue;
     }];
    return  btn;
}


- (RACSignal *)retryButtonTitleAndEnable{
    
    static const NSInteger n = 60;
    
    //定时器 主线程中 1秒执行一次
    RACSignal *timer = [[RACSignal interval:1
                                onScheduler:[RACScheduler mainThreadScheduler]]
                        map:^id(id value) {
                            return nil;
                        }];
    
    
    //将需要显示的秒数转化为一个数组
    NSMutableArray *numbers = [NSMutableArray array];
    for (NSInteger i = n; i >= 0; i--) {
        [numbers addObject:[NSNumber numberWithInteger:i]];
    }
    
    
    //两个信号关联 用zip保证每一秒取一个元素
    return [[[numbers.rac_sequence.signal zipWith:timer]
             map:^id(RACTuple *tuple) {
                 //秒数
                 NSNumber *number = tuple.first;
                 NSInteger count = number.integerValue;
                 
                 
                 //返回一个 集合对象（要显示的文字， 是否完成）
                 if (count == 0) {
                     return RACTuplePack(@"发送验证码",[NSNumber numberWithBool:YES]);
                 }else{
                     NSString *title = [NSString stringWithFormat:@"重试 %lds",(long)count];
                     return  RACTuplePack(title,[NSNumber numberWithBool:NO]);
                 }
             }]
            
            takeUntil:self.rac_willDeallocSignal] ;
    ;
}

@end
