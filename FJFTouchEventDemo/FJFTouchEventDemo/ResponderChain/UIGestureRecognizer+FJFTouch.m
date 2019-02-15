
//
//  UIGestureRecognizer+FJFTouch.m
//  FJFTouchEventDemo
//
//  Created by 方金峰 on 2019/2/14.
//  Copyright © 2019年 方金峰. All rights reserved.
//

#import <objc/runtime.h>
#import "UIGestureRecognizer+FJFTouch.h"

@implementation UIGestureRecognizer (FJFTouch)
//TouchEventHook.m
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
//        Class aSystemGestureClass = objc_getClass("_UISystemGestureGateGestureRecognizer");
//        Class aTapGestureClass = objc_getClass("UITapGestureRecognizer");
//        fjf_GestureSwizzle(aTapGestureClass, @selector(fjf_touchesBegan: withEvent:), @selector(touchesBegan: withEvent:));
//        fjf_GestureSwizzle(aSystemGestureClass, @selector(fjf_touchesBegan: withEvent:), @selector(touchesBegan: withEvent:));
//        
//        fjf_GestureSwizzle(aTapGestureClass, @selector(fjf_touchesEnded: withEvent:), @selector(touchesEnded: withEvent:));
//        fjf_GestureSwizzle(aSystemGestureClass, @selector(fjf_touchesEnded: withEvent:), @selector(touchesEnded: withEvent:));
//        
//        fjf_GestureSwizzle(aTapGestureClass, @selector(fjf_touchesCancelled: withEvent:), @selector(touchesCancelled: withEvent:));
//        fjf_GestureSwizzle(aSystemGestureClass, @selector(fjf_touchesCancelled: withEvent:), @selector(touchesCancelled: withEvent:));
    });
   
}

- (void)fjf_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [self fjf_touchesBegan:touches withEvent:event];
}

- (void)fjf_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [self fjf_touchesEnded:touches withEvent:event];
}

- (void)fjf_touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [self fjf_touchesCancelled:touches withEvent:event];
}


void fjf_GestureSwizzle(Class c, SEL orig, SEL new) {
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if (class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}
@end
