//
//  TabBarView.m
//  YYDApp
//
//  Created by YM on 16/7/14.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "TabBarView.h"
#import "TabBarDefine.h"

@interface TabBarView ()
{
    UIButton *currentBtn;
}

@end

@implementation TabBarView

- (void)configTabbarWithImages:(NSArray *)imagesArray{
    
    NSInteger imageCount = imagesArray.count;
    for (int i = 0; i < imageCount; i++) {
        NSDictionary *dic   = imagesArray[i];
        UIButton *btn       = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame           = CGRectMake((CGRectGetWidth(self.bounds)/imageCount)*i , 0,
                                         CGRectGetWidth(self.bounds)/imageCount, CGRectGetHeight(self.bounds));
        btn.tag             = 100 + i;
        
        [btn setImage:dic[kUnSelectedImage] forState:(UIControlStateNormal)];
        [btn setImage:dic[kSelectedImage] forState:(UIControlStateSelected)];
        [btn addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self addSubview:btn];
        
        if (i == 0) {
            btn.selected = YES;
            currentBtn = btn;
        }
    }
}


- (void)clicked:(id)sender{
    if (currentBtn == sender) {
        return;
    }
    currentBtn.selected = NO;
    currentBtn          = sender;
    currentBtn.selected = YES;
    NSInteger index     = currentBtn.tag - 100;
    [self imgAnimate:currentBtn withComplete:^{}];
    
    if (self.delegate) {
        [self.delegate tabbarView:self selectedIndex:index];
    }
}


- (void)imgAnimate:(UIButton*)btn withComplete:(void (^)())complete{
    
    UIView *view=btn.subviews[0];
    
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5, 0.5);
     } completion:^(BOOL finished){//do other thing
         [UIView animateWithDuration:0.2 animations:
          ^(void){
              view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2, 1.2);
          } completion:^(BOOL finished){//do other thing
              [UIView animateWithDuration:0.1 animations:
               ^(void){
                   view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
               } completion:^(BOOL finished){//do other thing
                   complete();
               }];
          }];
     }];
}


@end
