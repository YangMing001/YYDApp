//
//  RegisterVC.h
//  YYDApp
//
//  Created by YM on 16/8/2.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FromTypeLogin = 100,
    FromTyoeDafault,
} FromType;



@interface RegisterVC : UIViewController

@property (nonatomic,assign) FromType fromType;


@end
