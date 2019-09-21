
//
//  FJShapeCircleView.m
//  FJBezierPathDemo
//
//  Created by fjf on 2017/6/2.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJFShapeCircleView.h"
#import "FJFShapeCircleViewStyle.h"



static const CGFloat kDefaultCircleViewSize = 80.0f;

@interface FJFShapeCircleView()

@property (nonatomic, strong) UIBezierPath *trackPath;
// rotationLayer
@property (nonatomic, strong) CALayer *rotationLayer;

@property (nonatomic, strong) CAShapeLayer *trackLayer;

@property (nonatomic, strong) UIBezierPath *progressPath;

@property (nonatomic, strong) CAShapeLayer *progressLayer;
// gradientLayer
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
// circleViewStyle
@property (nonatomic, strong) FJFShapeCircleViewStyle *circleViewStyle;
@end

@implementation FJFShapeCircleView

#pragma mark --- init method

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, kDefaultCircleViewSize, kDefaultCircleViewSize)];
}


- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame circleViewStyle:[FJFShapeCircleViewStyle new]];
}


- (instancetype)initWithFrame:(CGRect)frame circleViewStyle:(FJFShapeCircleViewStyle *)circleViewStyle {
    if (self = [super initWithFrame:frame]) {
        _circleViewStyle = circleViewStyle;
        // 外圆
        CGFloat lineWidth = circleViewStyle.outterLineWidth;
        CGFloat radius = frame.size.width / 2.0f - lineWidth;
        if (circleViewStyle.circleRadius < radius) {
            radius = circleViewStyle.circleRadius;
        }
        self.trackPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
        self.trackLayer = [CAShapeLayer new];
        self.trackLayer.fillColor = circleViewStyle.outerCircleFillColor.CGColor;
        self.trackLayer.strokeColor = circleViewStyle.outerCircleStrokeColor.CGColor;
        self.trackLayer.path = self.trackPath.CGPath;
        self.trackLayer.lineWidth = lineWidth;
        self.trackLayer.frame = self.bounds;
        [self.layer addSublayer:self.trackLayer];
        
        
        // 旋转 圆
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = [UIColor clearColor].CGColor; //圆环底色
        layer.frame = self.bounds;
        [self.layer addSublayer:layer];
        self.rotationLayer = layer;
        
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = circleViewStyle.gradientLayerColors;
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        gradientLayer.locations = circleViewStyle.gradientLayerLocations;
        [layer addSublayer:gradientLayer];
        self.gradientLayer = gradientLayer;
        
        
        self.progressPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:radius startAngle:(M_PI * 1.5) endAngle:(M_PI * 3.5) clockwise:YES];
        self.progressPath.lineCapStyle = kCGLineCapRound;
        self.progressLayer = [CAShapeLayer new];
        self.progressLayer.fillColor = circleViewStyle.rotateCircleFillColor.CGColor;
        self.progressLayer.strokeColor = circleViewStyle.rotateCircleStrokeColor.CGColor;
        self.progressLayer.path = self.progressPath.CGPath;
        self.progressLayer.lineWidth = lineWidth;
        self.progressLayer.lineCap = kCALineCapRound;
        self.progressLayer.strokeStart = circleViewStyle.innerStrokeStart;
        self.progressLayer.strokeEnd = circleViewStyle.innerStrokeEnd;
        self.progressLayer.frame = self.bounds;
        gradientLayer.mask = self.progressLayer;
        [self startAnimation];

        
        // 内部圆
        CGFloat tmpSpacing = circleViewStyle.innerToOutterSpacing;
        CGFloat innderCircleRadius = radius - 2 * tmpSpacing;
        UIBezierPath *innerPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:innderCircleRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
        CAShapeLayer *innerShapeLayer = [CAShapeLayer new];
        innerShapeLayer.fillColor = circleViewStyle.innnerCircleFillColor.CGColor;
        innerShapeLayer.strokeColor = circleViewStyle.innerCircleStrokeColor.CGColor;
        innerShapeLayer.path = innerPath.CGPath;
        innerShapeLayer.lineWidth = circleViewStyle.innerLineWidth;
        innerShapeLayer.frame = self.bounds;
        innerShapeLayer.hidden = circleViewStyle.hiddenInnerCircle;
        [self.layer addSublayer:innerShapeLayer];
        
    }
    return self;
}


#pragma mark -------------------------- Public Methods
// 开始 动画 效果
- (void)startAnimation {
    [self startLoading:self.rotationLayer];
}

// 移除 动画 效果
- (void)removeAnimation {
    [self.rotationLayer removeAllAnimations];
}

// 开始 内圆 旋转
- (void)startInnerCircleRotationAnimation {
    [self.layer addSublayer:self.rotationLayer];
    [self startAnimation];
}

// 移除 内圆 旋转
- (void)stopInnerCircleRotationAnimation {
    [self.rotationLayer removeFromSuperlayer];
    [self removeAnimation];
}

#pragma mark -------------------------- Private Methods

// 动画
- (void)startLoading:(CALayer *)rotateView{
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    ani.duration = _circleViewStyle.animationDuration;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ani.repeatCount = HUGE_VALF;
    
    NSValue *value1 = [NSNumber numberWithFloat:0 * M_PI];
    NSValue *value2 = [NSNumber numberWithFloat:0.75 * M_PI];
    NSValue *value3 = [NSNumber numberWithFloat:1 * M_PI];
    NSValue *value4 = [NSNumber numberWithFloat:2 * M_PI];
    
    ani.values = @[value1, value2, value3, value4];
    
    ani.keyTimes = [NSArray arrayWithObjects:
                    [NSNumber numberWithFloat:0.0],
                    [NSNumber numberWithFloat:0.4],
                    [NSNumber numberWithFloat:0.7],
                    [NSNumber numberWithFloat:1.0],
                    nil];
    
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [rotateView addAnimation:ani forKey:nil];
    
}


@end
