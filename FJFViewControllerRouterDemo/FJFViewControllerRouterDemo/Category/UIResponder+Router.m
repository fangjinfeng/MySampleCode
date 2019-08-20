//
//  UIResponder+Router.m
//  FJFViewControllerRouterDemo
//
//  Created by 方金峰 on 2019/8/20.
//  Copyright © 2019 方金峰. All rights reserved.
//

#import <objc/runtime.h>
#import "UIResponder+Router.h"

static const char _FJFResponserViewControlerResponseBlockKey;

@implementation UIResponder (Router)

#pragma mark -------------------------- Public Methods

- (void)fjf_routerWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if (self.nextResponder) {
        [[self nextResponder] fjf_routerWithEventName:eventName userInfo:userInfo];
    }
}

- (void)fjf_routerWithUserInfo:(NSDictionary *)userInfo {
    [self fjf_routerWithEventName:NSStringFromClass([self class]) userInfo:userInfo];
}


#pragma mark -------------------------- Private Methods
- (UIResponder *)eventDispatcher{
    UIResponder * resp = self;
    do {
        if ([resp isKindOfClass:[UIViewController class]]) {
            return resp;
        }
        resp = resp.nextResponder;
    } while (resp != nil);
    return nil;
}

#pragma mark -------------------------- Getter / Setter
-(void)setFjf_viewControllerResponseBlock:(FJFUIResponderViewControllerResponseBlock)fjf_viewControllerResponseBlock {
    objc_setAssociatedObject([self eventDispatcher], &_FJFResponserViewControlerResponseBlockKey, fjf_viewControllerResponseBlock, OBJC_ASSOCIATION_COPY);
}


- (FJFUIResponderViewControllerResponseBlock)fjf_viewControllerResponseBlock{
    return objc_getAssociatedObject([self eventDispatcher], &_FJFResponserViewControlerResponseBlockKey);
}

@end
