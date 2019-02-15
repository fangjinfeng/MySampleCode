

//
//  UIView+FJFTouchEvent.m
//  FJFTouchEventDemo
//
//  Created by 方金峰 on 2019/2/13.
//  Copyright © 2019年 方金峰. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+FJFTouchEvent.h"

@implementation UIView (FJFTouchEvent)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        fjf_swizzle(self, @selector(pointInside:withEvent:), @selector(fjf_pointInside:withEvent:));
//        fjf_swizzle(self, @selector(hitTest:withEvent:), @selector(fjf_hitTest:withEvent:));
    });
}

void fjf_swizzle(Class c, SEL orig, SEL new) {
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if (class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

- (UIView *)fjf_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
     NSLog(@"%@ - %s", NSStringFromClass([self class]), __func__);
    return [self fjf_hitTest:point withEvent:event];
}


- (BOOL)fjf_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@ - %s", NSStringFromClass([self class]), __func__);
    return [self fjf_pointInside:point withEvent:event];
}
@end
