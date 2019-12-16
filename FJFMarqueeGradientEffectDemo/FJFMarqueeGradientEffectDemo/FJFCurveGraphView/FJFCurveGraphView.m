//
//  FJFCurveGraphView.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 03/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFCurveGraphView.h"


@implementation FJFCurveGraphViewStyle
#pragma mark - Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _strokeColor = [UIColor colorWithRed:255/255.0f green:107.0f/255.0f blue:0/255.0f alpha:1.0];
        _fillColor = [UIColor colorWithRed:255/255.0f green:225/255.0f blue:204/255.0f alpha:1.0];
        _labelTextColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
        _labelTextFont = [UIFont systemFontOfSize:10.0f];
        _singleItemViewValue = 100.0f;
        _singleItemViewHeight = 20.0f;
        _lineWidth = 1.0f;
        _tipCircleViewColor = [UIColor colorWithRed:255/255.0f green:107.0f/255.0f blue:0/255.0f alpha:1.0];
        _tipCircleViewSize = 4.0f;
        _valueTextArray = @[@"100", @"300", @"400", @"150", @"330", @"400",];
    }
    return self;
}

@end

@interface FJFCurveGraphView()
// tipLabelArray
@property (nonatomic, strong) NSArray <UILabel *>*tipLabelArray;
// circleViewArray
@property (nonatomic, strong) NSArray <UIView *>*circleViewArray;
// curveGraphShaperLayer
@property (nonatomic, strong) CAShapeLayer *curveGraphShaperLayer;
// leftLineView
@property (nonatomic, strong) UIView *leftLineView;
// rightLineView
@property (nonatomic, strong) UIView *rightLineView;
// viewStyle
@property (nonatomic, strong) FJFCurveGraphViewStyle *viewStyle;
@end

@implementation FJFCurveGraphView

#pragma mark - Life Circle
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame viewStyle:[[FJFCurveGraphViewStyle alloc] init]];
}

- (instancetype)initWithFrame:(CGRect)frame
       viewStyle:(FJFCurveGraphViewStyle *)viewStyle{
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
        [self updateBackgroundViewStyle:viewStyle];
    }
    return self;
}

#pragma mark - Public Methods
- (void)updateBackgroundViewStyle:(FJFCurveGraphViewStyle *)viewStyle {
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
    
    [self updateCircleViewArray];
    NSInteger showCircleViewCount = _viewStyle.valueTextArray.count;
    UIBezierPath *bezierpath = [UIBezierPath bezierPath];
    bezierpath.lineWidth = _viewStyle.lineWidth;
    CGPoint firstPoint = CGPointZero;
    if (showCircleViewCount == 1) {
        firstPoint = self.circleViewArray[0].center;
        self.curveGraphShaperLayer.hidden = YES;
    } else {
        __block CGPoint prePonit;
        [bezierpath moveToPoint:CGPointMake(0, self.frame.size.height)];
        [_viewStyle.valueTextArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                prePonit = self.circleViewArray[0].center;
                
            }
            CGPoint nowPoint = self.circleViewArray[idx].center;
            [bezierpath addCurveToPoint:nowPoint controlPoint1:CGPointMake((prePonit.x + nowPoint.x)/2, prePonit.y) controlPoint2:CGPointMake((prePonit.x + nowPoint.x)/2, nowPoint.y)]; //三次曲线
            prePonit = nowPoint;
        }];
        [bezierpath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    }
    CGPoint firstViewCenter = self.circleViewArray.firstObject.center;
    NSInteger lastObjectIndex = showCircleViewCount - 1;
    if (lastObjectIndex < 0) {
       lastObjectIndex = 0;
    }
    CGPoint lastViewCenter = self.circleViewArray[lastObjectIndex].center;
    CGFloat lineViewWidth = _viewStyle.lineWidth + 1;
    self.leftLineView.frame = CGRectMake(-1, firstViewCenter.y, lineViewWidth, self.frame.size.height - firstViewCenter.y);
    self.rightLineView.frame = CGRectMake(self.frame.size.width - _viewStyle.lineWidth/2.0f, lastViewCenter.y, lineViewWidth, self.frame.size.height - lastViewCenter.y);
    self.leftLineView.backgroundColor = _viewStyle.fillColor;
    self.rightLineView.backgroundColor = _viewStyle.fillColor;
    self.curveGraphShaperLayer.strokeColor = _viewStyle.strokeColor.CGColor;
    self.curveGraphShaperLayer.fillColor = _viewStyle.fillColor.CGColor;
    self.curveGraphShaperLayer.path = bezierpath.CGPath;
    self.curveGraphShaperLayer.lineWidth = _viewStyle.lineWidth;
}

#pragma mark - Private Methods

- (void)updateCircleViewArray {
    NSMutableArray *tmpLayerMarray = [NSMutableArray array];
    NSMutableArray *tmpLabelMarray = [NSMutableArray array];
    NSInteger currentShaperCount = _viewStyle.valueTextArray.count;
    NSInteger previousShaperCount = self.circleViewArray.count;

    // 如果 当前 shaperCount 大于 之前 shaperCount
    if (currentShaperCount > previousShaperCount) {

       [_viewStyle.valueTextArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           UIView *tmpView = nil;
           UILabel *tmpLabel = nil;
           if (idx < previousShaperCount) {
               tmpLabel = self.tipLabelArray[idx];
               tmpView = self.circleViewArray[idx];
           }
           else {
               tmpLabel = [self itemValueLabel];
               tmpView = [self tipCircleView];
               [self addSubview:tmpView];
               [self addSubview:tmpLabel];
           }
           tmpView.hidden = NO;
           NSString *valueText = _viewStyle.valueTextArray[idx];
           tmpLabel.text = valueText;
           CGRect circleViewFrame = [self tipCircleViewFrameWithViewIndex:idx viewValueText:valueText];
           tmpView.frame = circleViewFrame;
           
           tmpLabel.frame = [self itemLabelFrameWithViewIndex:idx viewValueText:valueText];
           [self updateTipCircleViewWithCircleView:tmpView];
           [tmpLayerMarray addObject:tmpView];
           [tmpLabelMarray addObject:tmpLabel];
       }];
    }
    // 如果 当前 shaperCount 小于等于 之前 shaperCount
    else {
       
       [self.circleViewArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           UILabel *tmpLabel = self.tipLabelArray[idx];
           if (idx < currentShaperCount) {
            obj.hidden = NO;
            tmpLabel.hidden = NO;
            NSString *valueText = _viewStyle.valueTextArray[idx];
            tmpLabel.text = valueText;
            tmpLabel.frame = [self itemLabelFrameWithViewIndex:idx viewValueText:valueText];
            CGRect circleViewFrame = [self tipCircleViewFrameWithViewIndex:idx viewValueText:valueText];
            obj.frame = circleViewFrame;
           } else {
               obj.hidden = YES;
               tmpLabel.hidden = YES;
           }
           [self updateTipCircleViewWithCircleView:obj];
           [tmpLayerMarray addObject:obj];
           [tmpLabelMarray addObject:tmpLabel];
       }];
    }
    self.circleViewArray = tmpLayerMarray;
    self.tipLabelArray = tmpLabelMarray;
}


- (CGRect)tipCircleViewFrameWithViewIndex:(NSInteger)viewIndex viewValueText:(NSString *)viewValueText{
    CGPoint tipCircleViewOrign = [self linePathPointWithViewIndex:viewIndex viewValueText:viewValueText];
    return CGRectMake(tipCircleViewOrign.x, tipCircleViewOrign.y, _viewStyle.tipCircleViewSize, _viewStyle.tipCircleViewSize);
}

- (CGRect)itemLabelFrameWithViewIndex:(NSInteger)viewIndex viewValueText:(NSString *)viewValueText{
    CGPoint tipCircleViewOrign = [self linePathPointWithViewIndex:viewIndex viewValueText:viewValueText];
    CGSize labelSize = [FJFCurveGraphView sizeForFont:_viewStyle.labelTextFont contentString:viewValueText];
    CGFloat labelX = tipCircleViewOrign.x - ((labelSize.width) / 2.0f) + (_viewStyle.tipCircleViewSize / 2.0f);
    CGFloat labelY = tipCircleViewOrign.y - labelSize.height - 2.0f;
    
    if (labelX < 0) {
        labelX = 2;
    }
    
    if (labelX + labelSize.width > self.frame.size.width) {
        labelX = self.frame.size.width - labelSize.width - 2.0f;
    }
    return CGRectMake(labelX, labelY, labelSize.width, labelSize.height);
}


- (CGPoint)linePathPointWithViewIndex:(NSInteger)viewIndex viewValueText:(NSString *)viewValueText {
    CGFloat viewValue = [viewValueText floatValue];
    CGFloat viewY = 0;
    if (_viewStyle.singleItemViewValue != 0) {
        viewY = self.frame.size.height - (viewValue / _viewStyle.singleItemViewValue) * _viewStyle.singleItemViewHeight - (_viewStyle.tipCircleViewSize / 2.0f);
    }
    CGFloat viewSpacing = self.frame.size.width / ((_viewStyle.valueTextArray.count - 1) * 1.0f);
    CGFloat viewX = (viewSpacing * viewIndex) - (_viewStyle.tipCircleViewSize / 2.0f);
    return CGPointMake(viewX, viewY);
}


- (void)updateTipCircleViewWithCircleView:(UIView *)circleView {
    circleView.backgroundColor = _viewStyle.tipCircleViewColor;
    circleView.layer.cornerRadius = _viewStyle.tipCircleViewSize / 2.0f;
}


- (void)setupViewControls {
    self.leftLineView = [[UIView alloc] init];
    self.rightLineView = [[UIView alloc] init];
    [self.layer addSublayer:self.curveGraphShaperLayer];

    [self addSubview:self.leftLineView];
    [self addSubview:self.rightLineView];
}


#pragma mark - Setter / Getter
// 图形
- (CAShapeLayer *)curveGraphShaperLayer {
    if (!_curveGraphShaperLayer) {
        _curveGraphShaperLayer = [CAShapeLayer layer];
        _curveGraphShaperLayer.frame = self.bounds;
    }
    return  _curveGraphShaperLayer;
}


- (UILabel *)itemValueLabel {
    UILabel *tmpLabel = [[UILabel alloc] init];
    tmpLabel.font = _viewStyle.labelTextFont;
    tmpLabel.textColor = _viewStyle.labelTextColor;
    return tmpLabel;
}

- (UIView *)tipCircleView {
    UIView *tmpView = [[UIView alloc] init];
    return tmpView;
}
@end
