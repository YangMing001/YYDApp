//
//  YMWebViewHelper.m
//  TJWebView
//
//  Created by YM on 16/7/13.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "YMWebViewHelper.h"
#import <objc/runtime.h>
#import "WebViewJSHandler.h"
@interface YMWebViewHelper()

@property (nonatomic,copy,readwrite) NSDictionary *ymHelperMethodDic;
@property (nonatomic,strong) WebViewJSHandler *ymHelperWebViewJSHandler;
@end

@implementation YMWebViewHelper

- (void)dealloc{
    NSLog(@"%s",__func__);
}

#pragma mark - Public Method
/**
 *  通过 methodName 做转发
 *
 *  @param methodName       方法名称
 *  @param data             数据
 *  @param responseCallback 回调
 */
- (void)ymHelperHandleName:(NSString *)methodName
              data:(id)data
          callBack:(YMResponseCallback)responseCallback{
    
    NSString *selString = [self ymHelperFindSELByJSName:methodName];
    //转换 string to SEL
    SEL sel = NSSelectorFromString(selString);
    
    if ([self.ymHelperWebViewJSHandler respondsToSelector:sel]) {
        
//忽略警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.ymHelperWebViewJSHandler performSelector:sel withObject:data withObject:responseCallback];
#pragma clang diagnostic pop
    }
    
}



#pragma mark - Private Method

/**
 *  通过runtime 获取方法列表
 *
 *  @return 方法名 和 js名 组成 的 字典
 */
- (NSDictionary *)ymHelperMethodListDic
{
    unsigned int count;
    Method *methods = class_copyMethodList([WebViewJSHandler class], &count);
    NSMutableDictionary *methodDictionary = [NSMutableDictionary dictionaryWithCapacity:count];
    
    for (int i = 0; i < count; i++)
    {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        
        /**
         *  过滤掉私有的方法
         */
        if (![name containsString:@"mHelper"] &&
            ![name containsString:@"."] &&
            ![name containsString:@"dealloc"]) {
            
            NSString *jsName = [[name componentsSeparatedByString:@":"] firstObject];
            NSLog(@"方法 名字 ==== %@",name);
            NSLog(@"js 名字 ==== %@",jsName);
            [methodDictionary setObject:name forKey:jsName];
        }
        
    }
    return methodDictionary;
}


/**
 *  通过 JS 名称 寻找 SEL
 *
 *  @param jsName JS名称
 */
- (NSString *)ymHelperFindSELByJSName:(NSString *)jsName{
    return self.ymHelperMethodDic[jsName];
}

#pragma mark - Getter And Setter

- (NSDictionary *)ymHelperMethodDic{
    if (!_ymHelperMethodDic) {
        _ymHelperMethodDic = [self ymHelperMethodListDic];
    }
    return _ymHelperMethodDic;
}

- (WebViewJSHandler *)ymHelperWebViewJSHandler{
    if (!_ymHelperWebViewJSHandler) {
        _ymHelperWebViewJSHandler = [[WebViewJSHandler alloc] init];
        _ymHelperWebViewJSHandler.ymHelperUserVC = self.ymHelperCurrentVC;
    }
    return _ymHelperWebViewJSHandler;
}



@end
