//
//  FJFLongPressGestureRecognizer.m
//  FJFTouchEventDemo
//
//  Created by 方金峰 on 2019/2/14.
//  Copyright © 2019年 方金峰. All rights reserved.
//

#import "FJFLongPressGestureRecognizer.h"

@implementation FJFLongPressGestureRecognizer
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
@end
