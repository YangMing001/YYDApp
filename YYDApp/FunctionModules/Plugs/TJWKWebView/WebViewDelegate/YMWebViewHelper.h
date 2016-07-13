//
//  YMWebViewHelper.h
//  TJWebView
//
//  Created by YM on 16/7/13.
//  Copyright © 2016年 YM. All rights reserved.
//

/**
 *
 *
 *  助手类
 *
 *  思路：通过runtime获取到自定义的JS方法列表(WebViewJSHandler类中)，转而调用
 *  用法：在 JS方法列表 下 自定义js方法
 *  参考用例：
 *  
 *  1 没有参数没有回调
 *      - (void)goLogin1{
 *              //做 跳转登录动作
 *      }
 *  2 有参数没有回调
 *      - （void)goLogin2:(id)data{
 *              // 使用 参数
 *              //做 跳转登录动作
 *      }
 *
 *  3 有参数有回调
 *      - (void)goLogin3:(id)data callBack:(YMResponseCallback)callBack{
 *
 *      }
 *  注意：在有回调没参数的情况下尽量使用第三种情况
 *      - (void)goLogin4:(id)data callBack:(YMResponseCallback)callBack{
 *          //不使用 data 即可
 *
 *      }
 *
 */
#import <Foundation/Foundation.h>
#import "WebViewDefine.h"



@interface YMWebViewHelper : NSObject

/**Helper 提供的 方法列表*/
@property (nonatomic,copy,readonly) NSDictionary *ymHelperMethodDic;

/*** 当前 VC*/
@property (nonatomic,weak) UIViewController *ymHelperCurrentVC;


/**
 *  通过JS的名称 处理相关回调
 *
 *  @param methodName       JS名称
 *  @param data             回调数据
 *  @param responseCallback 回调函数执行
 */
- (void)ymHelperHandleName:(NSString *)methodName
            data:(id )data
          callBack:(YMResponseCallback)responseCallback;






@end
