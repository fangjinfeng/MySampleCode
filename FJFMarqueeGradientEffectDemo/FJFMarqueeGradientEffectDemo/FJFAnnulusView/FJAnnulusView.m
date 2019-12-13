
//
//  FJShapeCircleView.m
//  FJBezierPathDemo
//
//  Created by fjf on 2017/6/2.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJAnnulusView.h"


@interface FJAnnulusView()<CAAnimationDelegate>

@property (nonatomic, strong) UIBezierPath *trackPath;

@property (nonatomic, strong) CAShapeLayer *trackLayer;

@property (nonatomic, strong) UIBezierPath *progressPath;

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@end

@implementation FJAnnulusView

#pragma mark --- init method

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 外圆
        CGPoint circleCenter = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0);
        self.trackPath = [UIBezierPath bezierPathWithArcCenter:circleCenter radius:15 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
        self.trackLayer = [CAShapeLayer new];
        self.trackLayer.fillColor = [UIColor clearColor].CGColor;
        self.trackLayer.strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor;
        self.trackLayer.path = self.trackPath.CGPath;
        self.trackLayer.lineWidth = 4.0;
        self.trackLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.layer addSublayer:self.trackLayer];
        
        
        // 内圆
        self.progressPath = [UIBezierPath bezierPathWithArcCenter:circleCenter radius:15 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        self.progressPath.lineCapStyle = kCGLineCapRound;
        self.progressLayer = [CAShapeLayer new];
        self.progressLayer.fillColor = [UIColor clearColor].CGColor;
        self.progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        self.progressLayer.path = self.progressPath.CGPath;
        self.progressLayer.lineWidth = 3.0f;
        self.progressLayer.lineCap = kCALineCapRound;
        self.progressLayer.strokeStart = 0;
        self.progressLayer.strokeEnd = 0.40;
        self.progressLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.layer addSublayer:self.progressLayer];
        [self startLoading:self.progressLayer];
        
        
    }
    return self;
}

#pragma mark --- Public Methods
- (void)startAnimation {
     [self startLoading:self.progressLayer];
}

- (void)stopAnimation {
    [self.progressLayer removeAllAnimations];
}
#pragma mark --- private method

// 动画
- (void)startLoading:(CAShapeLayer *)rotateView{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = 1;
    rotationAnimation.autoreverses = NO;
    rotationAnimation.repeatCount = 5;
//    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.delegate = self;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [rotateView addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

/* Called when the animation begins its active duration. */

- (void)animationDidStart:(CAAnimation *)anim {
     NSLog(@"animation is Start");
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        NSLog(@"animation is finished");
    }
}
@end
