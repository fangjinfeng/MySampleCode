//
//  UIResponder+Router.h
//  FJFViewControllerRouterDemo
//
//  Created by 方金峰 on 2019/8/20.
//  Copyright © 2019 方金峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FJFUIResponderViewControllerResponseBlock) (id _Nullable blongView, id _Nullable touchView, id _Nullable param);

@interface UIResponder (Router)

/**
 沿着响应链，找到第一个isDispatcherProvider提供的EventBus
 */
@property (nonatomic, copy) FJFUIResponderViewControllerResponseBlock _Nullable fjf_viewControllerResponseBlock;


/**
 携带 userInfo 进行 路由

 @param userInfo 携带 信息
 */
- (void)fjf_routerWithUserInfo:(NSDictionary *_Nullable)userInfo;

/**
 依据 名称 携带 信息 进行 路由

 @param eventName 事件 名称
 @param userInfo 携带 信息
 */
- (void)fjf_routerWithEventName:(NSString *_Nullable)eventName userInfo:(NSDictionary *_Nullable)userInfo;
@end
