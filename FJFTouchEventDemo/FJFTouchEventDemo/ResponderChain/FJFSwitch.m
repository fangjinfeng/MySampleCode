

//
//  FJFSwitch.m
//  FJFTouchEventDemo
//
//  Created by 方金峰 on 2019/2/15.
//  Copyright © 2019年 方金峰. All rights reserved.
//

#import "FJFSwitch.h"

@implementation FJFSwitch

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

@end
