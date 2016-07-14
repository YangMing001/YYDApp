//
//  UtilsMacro.h
//  JJ
//
//  Created by YM on 15/11/12.
//  Copyright © 2015年 YM. All rights reserved.
//

/**
 *  工具类的宏定义
 */
#ifndef UtilsMacro_h
#define UtilsMacro_h




//角度转弧度
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

//获取系统时间戳
#define CurentTimeSince1970 ([NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]])

#pragma mark -----判断相关

#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

#pragma mark -----图片加载
//加载图片宏：
#define LOADIMAGE(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]

#pragma mark -----颜色转化
//rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//设置颜色RGB
#define COLOR(R, G, B, A)    [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#endif /* UtilsMacro_h */
