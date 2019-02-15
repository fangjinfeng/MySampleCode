//
//  FJFTabbar.m
//  FJFTouchEventDemo
//
//  Created by 方金峰 on 2019/2/13.
//  Copyright © 2019年 方金峰. All rights reserved.
//

#import "FJFTabbar.h"

@implementation FJFTabbar

//TabBar
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    //将触摸点坐标转换到在CircleButton上的坐标
    CGPoint pointTemp = [self convertPoint:point toView:self.indicateView];
    //若触摸点在CricleButton上则返回YES
    if ([self.indicateView pointInside:pointTemp withEvent:event]) {
        return YES;
    }
    //否则返回默认的操作
    return [super pointInside:point withEvent:event];
}
@end
