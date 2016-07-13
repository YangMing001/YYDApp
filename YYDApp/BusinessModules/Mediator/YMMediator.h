//
//  YMMediator.h
//  Pods
//
//  Created by YM on 16/6/12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  调度者
 */
@interface YMMediator : NSObject

+ (instancetype)sharedInstance;

// 远程App调用入口
- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;
// 本地组件调用入口
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;


@end
