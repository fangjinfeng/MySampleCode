//
//  FJFShapeCircleViewStyle.m
//  FJFTestProject
//
//  Created by 方金峰 on 2018/10/17.
//  Copyright © 2018年 方金峰. All rights reserved.
//

#import "FJFShapeCircleViewStyle.h"

@implementation FJFShapeCircleViewStyle
#pragma mark -------------------------- Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _circleRadius = 70.0f;
        _outterLineWidth = 8.0f;
        _outerCircleStrokeColor = kColorValueAlpha(0xFFFFFF, 0.12f);
        _outerCircleFillColor = [UIColor clearColor];
        _rotateCircleFillColor = [UIColor clearColor];
        _rotateCircleStrokeColor = [UIColor whiteColor];
        _gradientLayerColors = @[
                                 (id)kColorValueAlpha(0x919191, 1.0f).CGColor,
                                 (id)kColorValueAlpha(0xFDFDFD, 1.0f).CGColor,
                                 ];
        _gradientLayerLocations = @[@0.35, @0.7];
        _innerStrokeStart = 0.1f;
        _innerStrokeEnd = 0.5f;
        _animationDuration = 0.8f;
        
        _hiddenInnerCircle = NO;
        _innerLineWidth = 8.0f;
        _innerToOutterSpacing = 8.0f;
        _innnerCircleFillColor = [UIColor clearColor];
        _innerCircleStrokeColor = kColorValueAlpha(0x979797, 0.124);
        
    }
    return self;
}

UIColor* kColorValueAlpha(int rgbValue,float alphaValue){
    return [UIColor colorWithRed: ((rgbValue >> 16) & 0xFF)/255.f
                           green:((rgbValue >> 8) & 0xFF)/255.f
                            blue:(rgbValue & 0xFF)/255.f
                           alpha:alphaValue];
}
@end
