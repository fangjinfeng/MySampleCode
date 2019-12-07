//
//  ShapeView.m
//  router
//
//  Created by macmini on 22/09/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFGradualCircleShapeView.h"

@implementation FJFGradualCircleShapeViewStyle
#pragma mark - Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _lineWidth = 5.0f;
        _isClockwise = YES;
        _gradientColorArray = @[
                                [UIColor redColor],
                                [UIColor blueColor],
                                [UIColor yellowColor],
                                [UIColor greenColor],
                                [UIColor purpleColor],
                                ];
    }
    return self;
}
@end



@interface FJFGradualCircleShapeView()
// progressLayer
@property (nonatomic, strong) CAShapeLayer *progressLayer;
// gradientLayerArray
@property (nonatomic, strong) NSArray <CAGradientLayer *>*gradientLayerArray;
// shapeViewStyle
@property (nonatomic, strong) FJFGradualCircleShapeViewStyle *shapeViewStyle;
@end

@implementation FJFGradualCircleShapeView

#pragma mark - Life Circle

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame shapeViewStyle:[[FJFGradualCircleShapeViewStyle alloc] init]];
}

- (instancetype)initWithFrame:(CGRect)frame
       shapeViewStyle:(FJFGradualCircleShapeViewStyle *)shapeViewStyle {
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
        [self updateShapeViewStyle:shapeViewStyle];
    }
    return self;
}

#pragma mark - Public Methods
// 更新 shapeViewStyle
- (void)updateShapeViewStyle:(FJFGradualCircleShapeViewStyle *)shapeViewStyle {
    NSAssert(shapeViewStyle.gradientColorArray.count == 5, @"渐变颜色必须为5个颜色");
    _shapeViewStyle = shapeViewStyle;
    if (shapeViewStyle) {
        [self.gradientLayerArray enumerateObjectsUsingBlock:^(CAGradientLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self circlePositionWithLayerPosition:idx isClockwise:shapeViewStyle.isClockwise positionBlock:^(CGPoint startPoint, CGPoint endPoint, NSArray *colorArray) {
                obj.startPoint = startPoint;
                obj.endPoint = endPoint;
                obj.colors = colorArray;
            }];
        }];
        
        UIBezierPath *progressPath = [self circlePath];
        self.progressLayer.path = progressPath.CGPath;
        self.progressLayer.lineWidth = shapeViewStyle.lineWidth;
    }
}




#pragma mark - Private Methods

- (void)setupViewControls {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CALayer *gradientLayer = [CALayer layer];
    gradientLayer.frame = self.bounds;

    NSMutableArray *tmpGradientLayerMarray = [NSMutableArray array];
    
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(0, 0, width/2.0,  height/2.0);
    [gradientLayer addSublayer:gradientLayer1];
    [tmpGradientLayerMarray addObject:gradientLayer1];
    
    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.frame = CGRectMake(0, height/2.0, width/2.0,  height/2.0);
    [gradientLayer addSublayer:gradientLayer2];
    [tmpGradientLayerMarray addObject:gradientLayer2];

    CAGradientLayer *gradientLayer3 = [CAGradientLayer layer];
    gradientLayer3.frame = CGRectMake(width/2.0, height/2.0, width/2.0,  height/2.0);
    [gradientLayer addSublayer:gradientLayer3];
    [tmpGradientLayerMarray addObject:gradientLayer3];
    
    
    CAGradientLayer *gradientLayer4 = [CAGradientLayer layer];
    gradientLayer4.frame = CGRectMake(width/2.0, 0, width/2.0,  height/2.0);
    [gradientLayer addSublayer:gradientLayer4];
    [tmpGradientLayerMarray addObject:gradientLayer4];
    [self.layer addSublayer:gradientLayer];
    self.gradientLayerArray = tmpGradientLayerMarray;

    self.progressLayer.frame = gradientLayer.bounds;
    [self.layer addSublayer:self.progressLayer];
    gradientLayer.mask = self.progressLayer;
}


- (void)circlePositionWithLayerPosition:(NSInteger)layerPosition isClockwise:(BOOL)isClockwise positionBlock:(void (^)(CGPoint startPoint, CGPoint endPoint, NSArray *colorArray))positionBlock {
    
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;

    switch (layerPosition) {
        case 0:
            startPoint = CGPointMake(1, 0);
            endPoint = CGPointMake(0, 1);
            break;
        case 1:
            startPoint = CGPointMake(0, 0);
            endPoint = CGPointMake(1, 1);
            break;
        case 2:
            startPoint = CGPointMake(0, 1);
            endPoint = CGPointMake(1, 0);
            break;
        case 3:
            startPoint = CGPointMake(1, 1);
            endPoint = CGPointMake(0, 0);
            break;
            
        default:
            break;
    }
    
    NSArray *colorArray = @[(__bridge id)_shapeViewStyle.gradientColorArray[layerPosition].CGColor, (__bridge id)_shapeViewStyle.gradientColorArray[layerPosition + 1].CGColor];
    NSInteger colorCount = _shapeViewStyle.gradientColorArray.count;
    if (isClockwise) {
       colorArray = @[(__bridge id)_shapeViewStyle.gradientColorArray[colorCount - layerPosition - 1].CGColor, (__bridge id)_shapeViewStyle.gradientColorArray[colorCount - layerPosition - 2].CGColor];
    }
    
    if (positionBlock) {
        positionBlock(startPoint, endPoint, colorArray);
    }
}


#pragma mark - Setter / Getter

- (UIBezierPath *)circlePath {
    CGFloat startAngle = - (M_PI/2);
    CGFloat endAngle = - (M_PI * 2.5);
    // 是否 顺时针
    if (_shapeViewStyle.isClockwise) {
        startAngle = M_PI * 1.5;
        endAngle = M_PI * 3.5;
    }
    CGPoint centerPoint = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
    CGFloat circleRadius = (self.frame.size.width - _shapeViewStyle.lineWidth) / 2.0f;
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:circleRadius startAngle:startAngle endAngle:endAngle clockwise:_shapeViewStyle.isClockwise];
    return progressPath;
}


// progressLayer
- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [[CAShapeLayer alloc] init];
        _progressLayer.fillColor =  [UIColor clearColor].CGColor;
        _progressLayer.strokeColor =  [UIColor whiteColor].CGColor;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.strokeStart = 0;
        _progressLayer.strokeEnd = 1.0f;
        _progressLayer.frame = self.bounds;
    }
    return _progressLayer;
}
@end
