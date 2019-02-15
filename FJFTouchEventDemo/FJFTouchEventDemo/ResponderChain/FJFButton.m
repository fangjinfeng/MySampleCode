
//
//  FJFButton.m
//  FJFTouchEventDemo
//
//  Created by 方金峰 on 2019/2/14.
//  Copyright © 2019年 方金峰. All rights reserved.
//

#import "FJFButton.h"

@implementation FJFButton


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [super touchesCancelled:touches withEvent:event];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    NSLog(@"%s",__func__);
    return YES;
}


- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    NSLog(@"%s",__func__);
    return YES;
}


- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    NSLog(@"%s",__func__);
}


- (void)cancelTrackingWithEvent:(nullable UIEvent *)event {
    NSLog(@"%s",__func__);
}
//// ImageControl.m
//- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
//    // 将事件传递到对象本身来处理
//    [super sendAction:@selector(handleAction:) to:self forEvent:event];
//}
//
//- (void)handleAction:(id)sender {
//
//    NSLog(@"handle Action");
//}

@end
