

//
//  FJFSegmentCircleView.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 03/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFSegmentCircleView.h"

@implementation FJFSegmentCircleViewStrokeModel
#pragma mark - Life Circle
+ (FJFSegmentCircleViewStrokeModel *)configWithStrokeStart:(CGFloat)strokeStart
                                                 strokeEnd:(CGFloat)strokeEnd {
    FJFSegmentCircleViewStrokeModel *tmpModel = [[FJFSegmentCircleViewStrokeModel alloc] init];
    tmpModel.strokeStart = strokeStart;
    tmpModel.strokeEnd = strokeEnd;
    return tmpModel;
}
@end


@implementation FJFSegmentCircleViewStyle
#pragma mark - Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _lineWidth = 15.0f;
        _isClockwise = YES;
        _startPositionType = FJFSegmentCircleViewStartPositionTypeBottom;
        _strokeColorArray = @[
                                [UIColor redColor],
                                [UIColor blueColor],
                                [UIColor greenColor],
                                [UIColor yellowColor],
                                [UIColor blackColor],
                            ];
        _strokePositionModelArray = @[
                                        [FJFSegmentCircleViewStrokeModel configWithStrokeStart:0.0f strokeEnd:0.2],
                                        [FJFSegmentCircleViewStrokeModel configWithStrokeStart:0.2f strokeEnd:0.3f],
                                        [FJFSegmentCircleViewStrokeModel configWithStrokeStart:0.3f strokeEnd:0.5f],
                                        [FJFSegmentCircleViewStrokeModel configWithStrokeStart:0.5f strokeEnd:0.7f],
                                        [FJFSegmentCircleViewStrokeModel configWithStrokeStart:0.7f strokeEnd:1.0],
                                    ];
    }
    return self;
}
@end



@interface FJFSegmentCircleView()

// shapeLayerMarray
@property (nonatomic, strong) NSArray <CAShapeLayer *>*shapeLayerArray;

// segmentCircleViewStyle
@property (nonatomic, strong) FJFSegmentCircleViewStyle *segmentCircleViewStyle;
@end

@implementation FJFSegmentCircleView
#pragma mark - Life Circle

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame segmentCircleViewStyle:[[FJFSegmentCircleViewStyle alloc] init]];
}

- (instancetype)initWithFrame:(CGRect)frame
       segmentCircleViewStyle:(FJFSegmentCircleViewStyle *)segmentCircleViewStyle{
    if (self = [super initWithFrame:frame]) {
        _segmentCircleViewStyle = segmentCircleViewStyle;
        [self updateSegmentCircleViewStyle:segmentCircleViewStyle];
    }
    return self;
}



#pragma mark - Public Methods
// 更新 配置 参数
- (void)updateSegmentCircleViewStyle:(FJFSegmentCircleViewStyle *)segmentCircleViewStyle {
    _segmentCircleViewStyle = segmentCircleViewStyle;
    if (segmentCircleViewStyle) {
        [self updateViewControls];
    }
}


// 更新 viewController
- (void)updateViewControls {
     NSAssert(_segmentCircleViewStyle.strokeColorArray.count == _segmentCircleViewStyle.strokePositionModelArray.count, @"strokeColorArray 和 strokePositionModelArray 数量 必须 一致");
    NSMutableArray *tmpLayerMarray = [NSMutableArray array];
    NSInteger currentShaperCount = _segmentCircleViewStyle.strokeColorArray.count;
    NSInteger previousShaperCount = self.shapeLayerArray.count;

    // 如果 当前 shaperCount 大于 之前 shaperCount
    if (currentShaperCount > previousShaperCount) {

      [_segmentCircleViewStyle.strokePositionModelArray enumerateObjectsUsingBlock:^(FJFSegmentCircleViewStrokeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          CAShapeLayer *shaperLayer = nil;
          if (idx < previousShaperCount) {
              shaperLayer = self.shapeLayerArray[idx];
          }
          else {
              shaperLayer = [self shapeLayer];
              [self.layer addSublayer:shaperLayer];
          }
          shaperLayer.hidden = NO;
          shaperLayer.lineWidth = _segmentCircleViewStyle.lineWidth;
          shaperLayer.strokeColor = _segmentCircleViewStyle.strokeColorArray[idx].CGColor;
          UIBezierPath *circlePath = [self circlePath];
          shaperLayer.path = circlePath.CGPath;
          shaperLayer.strokeStart = obj.strokeStart;
          shaperLayer.strokeEnd = obj.strokeEnd;
          [tmpLayerMarray addObject:shaperLayer];
      }];
    }
    // 如果 当前 shaperCount 小于等于 之前 shaperCount
    else {
      
      [self.shapeLayerArray enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          if (idx < currentShaperCount) {
              obj.hidden = NO;
              obj.lineWidth = _segmentCircleViewStyle.lineWidth;
              obj.strokeColor = _segmentCircleViewStyle.strokeColorArray[idx].CGColor;
              UIBezierPath *circlePath = [self circlePath];
              obj.path = circlePath.CGPath;
              FJFSegmentCircleViewStrokeModel *tmpModel = _segmentCircleViewStyle.strokePositionModelArray[idx];
              obj.strokeStart = tmpModel.strokeStart;
              obj.strokeEnd = tmpModel.strokeEnd;
          } else {
              obj.hidden = YES;
          }
           [tmpLayerMarray addObject:obj];
      }];
    }
    self.shapeLayerArray = tmpLayerMarray;
}


#pragma mark - Private Methods

- (void)circlePositionWithPositionBlock:(void (^)(CGFloat startAngle, CGFloat endAngle))positionBlock {
    CGFloat startAngle = - (M_PI/2);
    CGFloat endAngle = - (M_PI * 2.5);
    switch (_segmentCircleViewStyle.startPositionType) {
        case FJFSegmentCircleViewStartPositionTypeLeft:
            startAngle = - M_PI;
            endAngle = - 3 * M_PI;
            if (_segmentCircleViewStyle.isClockwise) {
                startAngle =  M_PI;
                endAngle =  3 * M_PI;
            }
            break;
        case FJFSegmentCircleViewStartPositionTypeTop:
            startAngle = -(M_PI/2);
            endAngle = -(M_PI * 2.5);
            if (_segmentCircleViewStyle.isClockwise) {
                startAngle = M_PI * 1.5;
                endAngle = M_PI * 3.5;
            }
            break;
        case FJFSegmentCircleViewStartPositionTypeRight:
            startAngle = 0;
            endAngle = -(M_PI * 2);
            if (_segmentCircleViewStyle.isClockwise) {
                startAngle = 0;
                endAngle = 2 * M_PI;
            }
            break;
        case FJFSegmentCircleViewStartPositionTypeBottom:
            startAngle = - 1.5 * M_PI;
            endAngle = - 3.5 * M_PI;
            if (_segmentCircleViewStyle.isClockwise) {
                startAngle = (M_PI/2);
                endAngle = 2.5 * M_PI;
            }
            break;
            
        default:
            break;
    }
    
    if (positionBlock) {
        positionBlock(startAngle, endAngle);
    }
}

#pragma mark - Setter / Getter

- (UIBezierPath *)circlePath {
    __block CGFloat tmpStartAngle = 0;
    __block CGFloat tmpEndAngle = 0;
    [self circlePositionWithPositionBlock:^(CGFloat startAngle, CGFloat endAngle) {
        tmpStartAngle = startAngle;
        tmpEndAngle = endAngle;
    }];
    
    CGPoint centerPoint = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
    CGFloat circleRadius = (self.frame.size.width - _segmentCircleViewStyle.lineWidth) / 2.0f;
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:circleRadius startAngle:tmpStartAngle endAngle:tmpEndAngle clockwise:_segmentCircleViewStyle.isClockwise];
    return progressPath;
}

// 图形
- (CAShapeLayer *)shapeLayer {
    //创建出CAShapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];

    shapeLayer.frame = self.bounds;
    //填充颜色为ClearColor
    shapeLayer.fillColor = [UIColor clearColor].CGColor;

    return  shapeLayer;
}
@end
