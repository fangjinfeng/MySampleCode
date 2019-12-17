//
//  FJFCurveGraphView.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 03/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFGradualCurveGraphView.h"

@implementation FJFGradualCurveGraphValueModel
#pragma mark - Public Methods
+ (FJFGradualCurveGraphValueModel *)configWithVerticalContentValue:(NSString *)verticalContentValue
                                            horizontalContentValue:(NSString *)horizontalContentValue {
    FJFGradualCurveGraphValueModel *tmpModel = [[FJFGradualCurveGraphValueModel alloc] init];
    tmpModel.verticalContentValue = verticalContentValue;
    tmpModel.horizontalContentValue = horizontalContentValue;
    return tmpModel;
}
@end

@implementation FJFGradualCurveGraphViewStyle
#pragma mark - Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _topLayerStrokeColor = [UIColor colorWithRed:237/255.0f green:79/255.0f blue:79/255.0f alpha:1.0];
        _topLayerFillColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0];
        _lineWidth = 2.0f;
        
        _bottomLayerFillColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0];
        _bottomLayerStrokeColor = [UIColor colorWithRed:60/255.0f green:127/255.0f blue:255/255.0f alpha:1.0];

        _lineCenterViewColor = [UIColor redColor];
        _lineCenterViewHeight = 0.5f;

        _singleVerticalItemViewValue = 20;
        _singleVerticalItemViewHeight = 40.0f;
        
        _singleHorizontalItemViewValue = 20;
        _singleHorizontalItemViewWidth = 60;
        
        _backgroundViewColor = [UIColor whiteColor];
        
        NSMutableArray *tmpMarray = [NSMutableArray array];
        {
            FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"10" horizontalContentValue:@"0"];
            [tmpMarray addObject:tmpModel];
        }
        
        {
            FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"20" horizontalContentValue:@"10"];
            [tmpMarray addObject:tmpModel];
        }
        
        {
            FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"0" horizontalContentValue:@"30"];
            [tmpMarray addObject:tmpModel];
        }
        
        {
            FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"-20" horizontalContentValue:@"40"];
            [tmpMarray addObject:tmpModel];
        }
        
        {
            FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"-10" horizontalContentValue:@"50"];
            [tmpMarray addObject:tmpModel];
        }
        
        {
            FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"0" horizontalContentValue:@"60"];
            [tmpMarray addObject:tmpModel];
        }
        
        {
            FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"30" horizontalContentValue:@"70"];
            [tmpMarray addObject:tmpModel];
        }
        
        {
            FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"0" horizontalContentValue:@"80"];
            [tmpMarray addObject:tmpModel];
        }
        
        {
            FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"-30" horizontalContentValue:@"90"];
            [tmpMarray addObject:tmpModel];
        }
        
        {
           FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"0" horizontalContentValue:@"100"];
           [tmpMarray addObject:tmpModel];
        }
        
        _valueTextValueModelArray = tmpMarray;
    }
    return self;
}
@end



@interface FJFGradualCurveGraphView()

// topCurveLineLayer
@property (nonatomic, strong) CAShapeLayer *topCurveLineLayer;

// topCurveGraphShaperLayer
@property (nonatomic, strong) CAShapeLayer *topCurveGraphShaperLayer;

// bottomCurveLineLayer
@property (nonatomic, strong) CAShapeLayer *bottomCurveLineLayer;

// bottomCurveGraphShaperLayer
@property (nonatomic, strong) CAShapeLayer *bottomCurveGraphShaperLayer;

// viewStyle
@property (nonatomic, strong) FJFGradualCurveGraphViewStyle *viewStyle;

@end

@implementation FJFGradualCurveGraphView

#pragma mark - Life Circle
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame viewStyle:[[FJFGradualCurveGraphViewStyle alloc] init]];
}

- (instancetype)initWithFrame:(CGRect)frame
       viewStyle:(FJFGradualCurveGraphViewStyle *)viewStyle{
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
        [self updateBackgroundViewStyle:viewStyle];
    }
    return self;
}

#pragma mark - Public Methods
- (void)updateBackgroundViewStyle:(FJFGradualCurveGraphViewStyle *)viewStyle {
    _viewStyle = viewStyle;
    if (_viewStyle) {
        [self updateViewControls];
    }
}

// 获取 尺寸
+ (CGSize)sizeForFont:(UIFont *)font contentString:(NSString *)contentString {
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    return [contentString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:options attributes:@{NSFontAttributeName:font} context:nil].size;
}

- (void)updateViewControls {

    [self updateShapeLayerFrame];
    
    UIBezierPath *topBezierpath = [UIBezierPath bezierPath];
    UIBezierPath *topBezierLinePath = [UIBezierPath bezierPath];
   
    
    UIBezierPath *bottomBezierpath = [UIBezierPath bezierPath];
    UIBezierPath *bottomBezierLinePath = [UIBezierPath bezierPath];

    __block CGPoint topPrePonit = CGPointZero;
    __block CGPoint bottomPrePonit = CGPointZero;

    CGFloat halfViewHeight = [self halfViewHeight];
    [topBezierpath moveToPoint:CGPointMake(0, halfViewHeight)];
    [bottomBezierpath moveToPoint:CGPointMake(0, 0)];
    [_viewStyle.valueTextValueModelArray enumerateObjectsUsingBlock:^(FJFGradualCurveGraphValueModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == 0) {
            topPrePonit =  [self topLinePathPointWithViewIndex:idx viewTextModel:obj];
            bottomPrePonit = [self bottomLinePathPointWithViewIndex:idx viewTextModel:obj];
            [topBezierLinePath moveToPoint:topPrePonit];
            [bottomBezierLinePath moveToPoint:bottomPrePonit];
        }
        CGPoint topNowPoint = [self topLinePathPointWithViewIndex:idx viewTextModel:obj];
        CGPoint bottomNowPoint = [self bottomLinePathPointWithViewIndex:idx viewTextModel:obj];
        [topBezierpath addCurveToPoint:topNowPoint controlPoint1:CGPointMake((topPrePonit.x + topNowPoint.x)/2, topPrePonit.y) controlPoint2:CGPointMake((topPrePonit.x + topNowPoint.x)/2, topNowPoint.y)]; //三次曲线

        [topBezierLinePath addCurveToPoint:topNowPoint controlPoint1:CGPointMake((topPrePonit.x + topNowPoint.x)/2, topPrePonit.y) controlPoint2:CGPointMake((topPrePonit.x + topNowPoint.x)/2, topNowPoint.y)]; //三次曲线
        
        [bottomBezierpath addCurveToPoint:bottomNowPoint controlPoint1:CGPointMake((bottomPrePonit.x + bottomNowPoint.x)/2, bottomPrePonit.y) controlPoint2:CGPointMake((bottomPrePonit.x + bottomNowPoint.x)/2, bottomNowPoint.y)]; //三次曲线

        [bottomBezierLinePath addCurveToPoint:bottomNowPoint controlPoint1:CGPointMake((bottomPrePonit.x + bottomNowPoint.x)/2, bottomPrePonit.y) controlPoint2:CGPointMake((bottomPrePonit.x + bottomNowPoint.x)/2, bottomNowPoint.y)]; //三次曲线

        topPrePonit = topNowPoint;
        bottomPrePonit = bottomNowPoint;
    }];
    
    [topBezierpath addLineToPoint:CGPointMake(self.frame.size.width, [self halfViewHeight])];
    [bottomBezierpath addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    
    
    self.topCurveLineLayer.strokeColor = _viewStyle.topLayerStrokeColor.CGColor;
    self.topCurveLineLayer.fillColor = [UIColor clearColor].CGColor;
    self.topCurveLineLayer.path = topBezierLinePath.CGPath;
    self.topCurveLineLayer.lineWidth = _viewStyle.lineWidth;
    
    
    self.topCurveGraphShaperLayer.strokeColor = [UIColor clearColor].CGColor;
    self.topCurveGraphShaperLayer.fillColor = _viewStyle.topLayerFillColor.CGColor;
    self.topCurveGraphShaperLayer.path = topBezierpath.CGPath;
    self.topCurveGraphShaperLayer.lineWidth = _viewStyle.lineWidth;
    
    
    self.bottomCurveLineLayer.strokeColor = _viewStyle.bottomLayerStrokeColor.CGColor;
    self.bottomCurveLineLayer.fillColor = [UIColor clearColor].CGColor;
    self.bottomCurveLineLayer.path = bottomBezierLinePath.CGPath;
    self.bottomCurveLineLayer.lineWidth = _viewStyle.lineWidth;
    
    
    self.bottomCurveGraphShaperLayer.strokeColor = [UIColor clearColor].CGColor;
    self.bottomCurveGraphShaperLayer.fillColor = _viewStyle.bottomLayerFillColor.CGColor;
    self.bottomCurveGraphShaperLayer.path = bottomBezierpath.CGPath;
    self.bottomCurveGraphShaperLayer.lineWidth = _viewStyle.lineWidth;
}

#pragma mark - Private Methods

- (CGPoint)topLinePathPointWithViewIndex:(NSInteger)viewIndex viewTextModel:(FJFGradualCurveGraphValueModel *)viewTextModel {
    CGFloat horizontalValue = [viewTextModel.horizontalContentValue floatValue];
    CGFloat verticalValue = [viewTextModel.verticalContentValue floatValue];
    CGFloat halfViewHeight = self.frame.size.height / 2.0f;
    CGFloat viewY = halfViewHeight - ((verticalValue / _viewStyle.singleVerticalItemViewValue) * _viewStyle.singleVerticalItemViewHeight);
    if(verticalValue < 0) {
        viewY = halfViewHeight + ((fabs(verticalValue) / _viewStyle.singleVerticalItemViewValue) * _viewStyle.singleVerticalItemViewHeight);
    }
    CGFloat viewX = (horizontalValue / _viewStyle.singleHorizontalItemViewValue) * _viewStyle.singleHorizontalItemViewWidth;
    return CGPointMake(viewX, viewY);
}

- (CGPoint)bottomLinePathPointWithViewIndex:(NSInteger)viewIndex viewTextModel:(FJFGradualCurveGraphValueModel *)viewTextModel {
    CGFloat horizontalValue = [viewTextModel.horizontalContentValue floatValue];
    CGFloat verticalValue = [viewTextModel.verticalContentValue floatValue];
    CGFloat viewY = - (verticalValue / _viewStyle.singleVerticalItemViewValue) * _viewStyle.singleVerticalItemViewHeight;
    if(verticalValue < 0) {
        viewY =  ((fabs(verticalValue) / _viewStyle.singleVerticalItemViewValue) * _viewStyle.singleVerticalItemViewHeight);
    }
    CGFloat viewX = (horizontalValue / _viewStyle.singleHorizontalItemViewValue) * _viewStyle.singleHorizontalItemViewWidth;
    return CGPointMake(viewX, viewY);
}


- (void)setupViewControls {
    [self.layer addSublayer:self.topCurveLineLayer];
    [self.layer addSublayer:self.topCurveGraphShaperLayer];
    
    [self.layer addSublayer:self.bottomCurveLineLayer];
    [self.layer addSublayer:self.bottomCurveGraphShaperLayer];
}

- (CGFloat)halfViewHeight {
    return self.frame.size.height / 2.0f;
}

- (void)updateShapeLayerFrame {
    CGFloat shaperLayerHeight = [self halfViewHeight];
    CGFloat topLayerY = 0;
    CGFloat shaperLayerX = 0;
    CGFloat bottomLayerY = shaperLayerHeight;
    CGFloat shaperLayerWidth = self.frame.size.width;
    _topCurveLineLayer.frame = CGRectMake(shaperLayerX, topLayerY, shaperLayerWidth, shaperLayerHeight);
    _topCurveGraphShaperLayer.frame = _topCurveLineLayer.frame;
    
    _bottomCurveLineLayer.frame = CGRectMake(shaperLayerX, bottomLayerY, shaperLayerWidth, shaperLayerHeight);
    _bottomCurveGraphShaperLayer.frame = _bottomCurveLineLayer.frame;
}

#pragma mark - Setter / Getter

// 下半部分 曲线
- (CAShapeLayer *)topCurveLineLayer {
    if (!_topCurveLineLayer) {
        _topCurveLineLayer = [CAShapeLayer layer];
        _topCurveLineLayer.masksToBounds = YES;
    }
    return  _topCurveLineLayer;
}



// 上半部分 图形
- (CAShapeLayer *)topCurveGraphShaperLayer {
    if (!_topCurveGraphShaperLayer) {
        _topCurveGraphShaperLayer = [CAShapeLayer layer];
        _topCurveGraphShaperLayer.masksToBounds = YES;
    }
    return  _topCurveGraphShaperLayer;
}


// 下半部分 曲线
- (CAShapeLayer *)bottomCurveLineLayer {
    if (!_bottomCurveLineLayer) {
        _bottomCurveLineLayer = [CAShapeLayer layer];
        _bottomCurveLineLayer.masksToBounds = YES;
    }
    return  _bottomCurveLineLayer;
}



// 下半部分 图形
- (CAShapeLayer *)bottomCurveGraphShaperLayer {
    if (!_bottomCurveGraphShaperLayer) {
        _bottomCurveGraphShaperLayer = [CAShapeLayer layer];
        _bottomCurveGraphShaperLayer.masksToBounds = YES;
    }
    return  _bottomCurveGraphShaperLayer;
}
@end
