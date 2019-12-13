//
//  FJFIndicatorTriangleView.m
//  FJFMarqueeGradientEffect
//
//  Created by macmini on 19/11/2019.
//  Copyright © 2019 FJFMarqueeGradientEffect. All rights reserved.
//

#import "FJFIndicatorTriangleView.h"

@interface FJFIndicatorTriangleView()
// triangleShapeLayer 三角型
@property (nonatomic, strong) CAShapeLayer *triangleShapeLayer;
@end

@implementation FJFIndicatorTriangleView

#pragma mark - Life Circle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
        [self updateViewControls];
    }
    return self;
}

#pragma mark - Public Methods

- (void)updateViewControls {
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    CGFloat viewHeight = self.frame.size.height;
    CGFloat viewWidth = self.frame.size.width;
    CGFloat halfViewWidth = viewWidth / 2.0f;
    CGFloat halfViewHeight = viewHeight / 2.0f;
    
    
    CGPoint firstPoint = CGPointMake(0, viewHeight);
    CGPoint secondPoint = CGPointMake(viewWidth, viewHeight);
    CGPoint threePoint = CGPointMake(halfViewWidth, 0);
    // 三角形 指向 下方
    if (self.triangleViewType == FJFIndicatorTriangleViewTypeBottom) {
        firstPoint = CGPointMake(0, 0);
        secondPoint = CGPointMake(viewWidth, 0);
        threePoint = CGPointMake(halfViewWidth, viewHeight);
    }
    // 三角形 指向 左边
    else if (self.triangleViewType == FJFIndicatorTriangleViewTypeLeft) {
        firstPoint = CGPointMake(viewWidth, 0);
        secondPoint = CGPointMake(viewWidth, viewHeight);
        threePoint = CGPointMake(0, halfViewHeight);
    }
    // 三角形 指向 右边
    else if (self.triangleViewType == FJFIndicatorTriangleViewTypeRight) {
        firstPoint = CGPointMake(0, 0);
        secondPoint = CGPointMake(0, viewHeight);
        threePoint = CGPointMake(viewWidth, halfViewHeight);
    }
    [aPath moveToPoint:firstPoint];
    [aPath addLineToPoint:secondPoint];
    [aPath addLineToPoint:threePoint];
    [aPath closePath];
    
    self.triangleShapeLayer.frame = self.bounds;
    self.triangleShapeLayer.path = aPath.CGPath;
    self.triangleShapeLayer.fillColor = self.fillColor.CGColor;
}

- (void)updateLineWidth:(CGFloat)lineWidth {
     self.triangleShapeLayer.lineWidth = lineWidth;
}

- (void)updateFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    self.triangleShapeLayer.fillColor = fillColor.CGColor;
}

- (void)updateStrokeColor:(UIColor *)strokeColor {
     self.triangleShapeLayer.strokeColor = strokeColor.CGColor;
     self.triangleShapeLayer.strokeStart = [self bottomSideRate];
     self.triangleShapeLayer.strokeEnd = 1;

}
#pragma mark -Private Methods

- (void)setupViewControls {
    [self.layer addSublayer:self.triangleShapeLayer];
    self.fillColor = [UIColor whiteColor];
}


// 底边长 比例
- (CGFloat)bottomSideRate {
    CGFloat bottomSideLength = [self bottomSideLength];
    CGFloat totalSideLength = [self triangleLengthOfSide];
    return bottomSideLength / totalSideLength;
}



// 三角形 边长
- (CGFloat)triangleLengthOfSide {
    CGFloat bottomSideLength = [self bottomSideLength];
    CGFloat halfBottomSideLength = bottomSideLength / 2.0f;
    CGFloat triangleHeight = [self triangleHeight];
    CGFloat sideLength = sqrt(halfBottomSideLength * halfBottomSideLength + triangleHeight * triangleHeight);
    return bottomSideLength + (2 * sideLength);
}


// 底部 边长
- (CGFloat)bottomSideLength {
    if (self.triangleViewType == FJFIndicatorTriangleViewTypeTop ||
        self.triangleViewType == FJFIndicatorTriangleViewTypeBottom) {
        return self.frame.size.width;
    }
    return self.frame.size.height;
}

// 三角形 高度
- (CGFloat)triangleHeight {
    if (self.triangleViewType == FJFIndicatorTriangleViewTypeTop ||
       self.triangleViewType == FJFIndicatorTriangleViewTypeBottom) {
       return self.frame.size.height;
    }
    return self.frame.size.width;
}

#pragma mark - Setter / Getter

- (CAShapeLayer *)triangleShapeLayer {
    if (!_triangleShapeLayer) {
        _triangleShapeLayer = [CAShapeLayer layer];
        _triangleShapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    }
    return _triangleShapeLayer;
}
@end
