//
//  FJFCurveGraphBackgroundView.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 03/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

// view
#import "FJFCurveGraphView.h"
#import "FJFCurveGraphBackgroundView.h"

@implementation FJFCurveGraphBackgroundControlsProperty
#pragma mark - Life Circle
- (instancetype)init {
    if (self = [super init]) {
        
        _verticalFont = [UIFont systemFontOfSize:10];
        _horizontalFont = [UIFont systemFontOfSize:10];
        _verticalTextColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
        _horizontalTextColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
        _lineViewBackgroundColor = [UIColor colorWithRed:233/255.0f green:234/255.0f blue:235/255.0f alpha:1.0f];
    }
    return self;
}
@end

@implementation FJFCurveGraphBackgroundViewStyle
#pragma mark - Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _lineViewHeight = 0.5f;
        _leftEdgeSpacing = 8.0f;
        _rightEdgeSpacing = 10.0f;
        _verticalLabelWidth = 26.0f;
        _horizontalLabelWidth = 27.0f;
        _verticalTextArray = @[@"0", @"100", @"200", @"300", @"400", @"500", @"600", @"700",];
        _horizontalTextArray = @[@"11-03", @"11-04", @"11-05", @"11-06", @"11-07", @"11-08", @"11-09"];
        _verticalViewSpacing = 20.0f;
        _labelToVerticalLineSpacing = 4.0f;
        _curveGraphViewTopEdgeSpacing = 15.0f;
         _hideVerticalFirstLabel = YES;
        _horizontalLabelToCurveGraphViewSpacing = 6.0f;
        _curveGraphBackgroundViewWidth = [UIScreen mainScreen].bounds.size.width - 2 * 12.0f;
        _controlsPropertyStyle = [[FJFCurveGraphBackgroundControlsProperty alloc] init];
    }
    return self;
}
@end

@interface FJFCurveGraphBackgroundView()
// horizontalLineViewArray
@property (nonatomic, strong) NSArray <UIView *>*horizontalLineViewArray;
// verticalLabelArray
@property (nonatomic, strong) NSArray <UILabel *> *verticalLabelArray;
// horizontalLabelArray
@property (nonatomic, strong) NSArray <UILabel *> *horizontalLabelArray;
// verticalLineView
@property (nonatomic, strong) UIView *verticalLineView;
// curveGraphLineContainerView
@property (nonatomic, strong) UIView *curveGraphLineContainerView;
// viewStyle
@property (nonatomic, strong) FJFCurveGraphBackgroundViewStyle *viewStyle;
@end

@implementation FJFCurveGraphBackgroundView

#pragma mark - Life Circle
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame viewStyle:[[FJFCurveGraphBackgroundViewStyle alloc] init]];
}

- (instancetype)initWithFrame:(CGRect)frame
       viewStyle:(FJFCurveGraphBackgroundViewStyle *)viewStyle{
    if (self = [super initWithFrame:frame]) {
        _viewStyle = viewStyle;
        [self setupViewControls];
        [self updateBackgroundViewStyle:viewStyle];
    }
    return self;
}

#pragma mark - Override Methods
- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateViewControls];
}

#pragma mark - Public Methods
- (void)updateBackgroundViewStyle:(FJFCurveGraphBackgroundViewStyle *)backgroundViewStyle {
    _viewStyle = backgroundViewStyle;
    if (backgroundViewStyle) {
        [self updateViewControls];
    }
}

- (void)updateViewControls {
    [self updateCurveGraphLineContainerView];
    [self updateHorizontalLabelArray];
    [self updateVerticalLabelArray];
    [self updateHorizontalLineViewArray];
}
#pragma mark - Private Methods

- (void)setupViewControls {
    self.verticalLineView = [self lineView];
    [self addSubview:self.curveGraphLineContainerView];
    [self.curveGraphLineContainerView addSubview:self.verticalLineView];
}


// 更新 曲线 容器 位置
- (void)updateCurveGraphLineContainerView {
    // 曲线图 容器
    CGFloat topEdgeSpacing = _viewStyle.curveGraphViewTopEdgeSpacing;
    CGFloat leftEdgeSpacing = _viewStyle.leftEdgeSpacing + _viewStyle.verticalLabelWidth + _viewStyle.labelToVerticalLineSpacing;
    CGFloat viewWidth = [self curveGraphContainerViewWidth];
    CGFloat viewHeight = _viewStyle.verticalViewSpacing * _viewStyle.verticalTextArray.count;
    self.curveGraphLineContainerView.frame = CGRectMake(leftEdgeSpacing, topEdgeSpacing, viewWidth, viewHeight);
    
    // 分割线
    CGFloat verticalLineViewHeight = viewHeight;
    CGFloat verticalLineViewWidth = _viewStyle.lineViewHeight;
    self.verticalLineView.backgroundColor = _viewStyle.controlsPropertyStyle.lineViewBackgroundColor;
    self.verticalLineView.frame = CGRectMake(0, 0, verticalLineViewWidth, verticalLineViewHeight);
}

// 更新 水平 分割线
- (void)updateHorizontalLineViewArray {
    NSMutableArray *tmpLayerMarray = [NSMutableArray array];
    NSInteger currentShaperCount = _viewStyle.verticalTextArray.count;
    NSInteger previousShaperCount = self.horizontalLineViewArray.count;

    // 如果 当前 shaperCount 大于 之前 shaperCount
    if (currentShaperCount > previousShaperCount) {
        for (NSInteger tmpIndex = 0; tmpIndex < currentShaperCount; tmpIndex++) {
            UIView *tmpView = nil;
            if (tmpIndex < previousShaperCount) {
                tmpView = self.horizontalLineViewArray[tmpIndex];
            }
            else {
                tmpView = [self lineView];
                [self.curveGraphLineContainerView addSubview:tmpView];
            }
            tmpView.hidden = NO;
            tmpView.frame = [self horizontalLineViewFrameWithViewIndex:tmpIndex];
            tmpView.backgroundColor = _viewStyle.controlsPropertyStyle.lineViewBackgroundColor;
            [tmpLayerMarray addObject:tmpView];
        }
    }
     // 如果 当前 shaperCount 小于等于 之前 shaperCount
    else {
        
        [self.horizontalLineViewArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < currentShaperCount) {
                obj.hidden = NO;
            } else {
                obj.hidden = YES;
            }
            obj.frame = [self horizontalLineViewFrameWithViewIndex:idx];
            [tmpLayerMarray addObject:obj];
        }];
    }
    self.horizontalLineViewArray = tmpLayerMarray;
}




// 更新 垂直 label 数组
- (void)updateVerticalLabelArray {
    NSMutableArray *tmpLayerMarray = [NSMutableArray array];
    NSInteger currentShaperCount = _viewStyle.verticalTextArray.count;
    NSInteger previousShaperCount = self.verticalLabelArray.count;
    
    // 如果 当前 shaperCount 大于 之前 shaperCount
    if (currentShaperCount > previousShaperCount) {
        [_viewStyle.verticalTextArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *tmpLabel = nil;
            if (idx < previousShaperCount) {
                tmpLabel = self.verticalLabelArray[idx];
            }
            else {
                tmpLabel = [self verticalTextLabel];
                [self addSubview:tmpLabel];
            }
            
            if (idx == 0) {
               tmpLabel.hidden = _viewStyle.hideVerticalFirstLabel;
            }
            tmpLabel.text = obj;
            tmpLabel.hidden = NO;
            tmpLabel.frame = [self verticalLabelFrameWithLabelIndex:idx];
            [self updateVerticalTextLabelWithTextLabel:tmpLabel];
            [tmpLayerMarray addObject:tmpLabel];
        }];
    }
     // 如果 当前 shaperCount 小于等于 之前 shaperCount
    else {
        
        [self.verticalLabelArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < currentShaperCount) {
                obj.hidden = NO;
                obj.text = _viewStyle.verticalTextArray[idx];
                obj.frame = [self verticalLabelFrameWithLabelIndex:idx];
            } else {
                obj.hidden = YES;
            }
            
            if (idx == 0) {
                obj.hidden = _viewStyle.hideVerticalFirstLabel;
            }
            [self updateVerticalTextLabelWithTextLabel:obj];
            [tmpLayerMarray addObject:obj];
        }];
    }
    self.verticalLabelArray = tmpLayerMarray;
}



// 更新 水平 label 数组
- (void)updateHorizontalLabelArray {
    NSMutableArray *tmpLayerMarray = [NSMutableArray array];
    NSInteger currentShaperCount = _viewStyle.horizontalTextArray.count;
    NSInteger previousShaperCount = self.horizontalLabelArray.count;

    // 如果 当前 shaperCount 大于 之前 shaperCount
    if (currentShaperCount > previousShaperCount) {

        [_viewStyle.horizontalTextArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *tmpLabel = nil;
            if (idx < previousShaperCount) {
                tmpLabel = self.horizontalLabelArray[idx];
            }
            else {
                tmpLabel = [self horizontalTextLabel];
                [self addSubview:tmpLabel];
            }
            tmpLabel.text = obj;
            tmpLabel.hidden = NO;
            tmpLabel.frame = [self horizontalLabelFrameWithLabelIndex:idx];
            [self updateHorizontalTextLabelWithTextLabel:tmpLabel];
            [tmpLayerMarray addObject:tmpLabel];
        }];
    }
     // 如果 当前 shaperCount 小于等于 之前 shaperCount
    else {
        [self.horizontalLabelArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < currentShaperCount) {
                obj.hidden = NO;
                obj.text = _viewStyle.horizontalTextArray[idx];
                obj.frame = [self horizontalLabelFrameWithLabelIndex:idx];
            } else {
                obj.hidden = YES;
            }
            [self updateHorizontalTextLabelWithTextLabel:obj];
            [tmpLayerMarray addObject:obj];
        }];
    }
    self.horizontalLabelArray = tmpLayerMarray;
}

// 水平 分割线 位置
- (CGRect)horizontalLineViewFrameWithViewIndex:(NSInteger)viewIndex {
    CGFloat lineViewX = 0;
    CGFloat lineViewHeight = _viewStyle.lineViewHeight;
    CGFloat lineViewWidth = self.curveGraphLineContainerView.frame.size.width;
    CGFloat lineViewY = self.curveGraphLineContainerView.frame.size.height - (viewIndex * _viewStyle.verticalViewSpacing);
    return CGRectMake(lineViewX, lineViewY, lineViewWidth, lineViewHeight);
}


// 垂直 label 位置
- (CGRect)verticalLabelFrameWithLabelIndex:(NSInteger)labelIndex {
    CGFloat labelX = _viewStyle.leftEdgeSpacing;
    CGFloat labelWidth = _viewStyle.verticalLabelWidth;
    CGFloat labelHeight = [FJFCurveGraphView sizeForFont:_viewStyle.controlsPropertyStyle.verticalFont contentString:_viewStyle.verticalTextArray[labelIndex]].height;
    CGFloat labelY = CGRectGetMaxY(self.curveGraphLineContainerView.frame) - labelIndex * _viewStyle.verticalViewSpacing - (labelHeight / 2.0f);
    return CGRectMake(labelX, labelY, labelWidth, labelHeight);
}

// 获取 底部 水平label 位置
- (CGRect)horizontalLabelFrameWithLabelIndex:(NSInteger)labelIndex {
    CGFloat curveGraphViewWidth = [self curveGraphContainerViewWidth];
    CGFloat labelWidth = curveGraphViewWidth  / (_viewStyle.horizontalTextArray.count - 1);
    CGFloat labelY = CGRectGetMaxY(self.curveGraphLineContainerView.frame) + _viewStyle.horizontalLabelToCurveGraphViewSpacing;
    CGFloat labelHeight = [FJFCurveGraphView sizeForFont:_viewStyle.controlsPropertyStyle.horizontalFont contentString:_viewStyle.horizontalTextArray[labelIndex]].height;
    CGFloat offsetX = self.curveGraphLineContainerView.frame.origin.x + (labelIndex * labelWidth) - (labelWidth / 2.0f);
    if (labelIndex == (_viewStyle.horizontalTextArray.count - 1)) {
        offsetX = offsetX - 10.0f;
    }
    CGFloat labelX = offsetX;
    return CGRectMake(labelX, labelY, labelWidth, labelHeight);
}





// 更新 水平 文本 属性
- (void)updateHorizontalTextLabelWithTextLabel:(UILabel *)textLabel {
    textLabel.font = _viewStyle.controlsPropertyStyle.horizontalFont;
    textLabel.textColor = _viewStyle.controlsPropertyStyle.horizontalTextColor;
}

// 更新 垂直 文本 属性
- (void)updateVerticalTextLabelWithTextLabel:(UILabel *)textLabel {
    textLabel.font = _viewStyle.controlsPropertyStyle.verticalFont;
    textLabel.textColor = _viewStyle.controlsPropertyStyle.verticalTextColor;
}


///  曲线 容器 宽度
- (CGFloat)curveGraphContainerViewWidth {
    CGFloat leftEdgeSpacing = _viewStyle.leftEdgeSpacing + _viewStyle.verticalLabelWidth + _viewStyle.labelToVerticalLineSpacing;
    CGFloat rightEdgeSpacing = _viewStyle.rightEdgeSpacing;
    return _viewStyle.curveGraphBackgroundViewWidth - leftEdgeSpacing - rightEdgeSpacing;
}

#pragma mark - Setter / Getter
- (UIView *)lineView {
    UIView *tmpView = [[UIView alloc] init];
    tmpView.backgroundColor = _viewStyle.controlsPropertyStyle.lineViewBackgroundColor;
    return tmpView;
}

// curveGraphLineContainerView
- (UIView *)curveGraphLineContainerView {
    if (!_curveGraphLineContainerView) {
        _curveGraphLineContainerView = [[UIView alloc] init];
    }
    return _curveGraphLineContainerView;
}

- (UILabel *)verticalTextLabel {
    UILabel *tmpLabel = [[UILabel alloc] init];
    tmpLabel.font = _viewStyle.controlsPropertyStyle.verticalFont;
    tmpLabel.textColor = _viewStyle.controlsPropertyStyle.verticalTextColor;
    tmpLabel.textAlignment = NSTextAlignmentRight;
    tmpLabel.lineBreakMode = NSLineBreakByCharWrapping;
    return tmpLabel;
}

- (UILabel *)horizontalTextLabel {
    UILabel *tmpLabel = [[UILabel alloc] init];
    tmpLabel.font = _viewStyle.controlsPropertyStyle.horizontalFont;
    tmpLabel.textColor = _viewStyle.controlsPropertyStyle.horizontalTextColor;
    tmpLabel.textAlignment = NSTextAlignmentCenter;
    tmpLabel.lineBreakMode = NSLineBreakByCharWrapping;
    return tmpLabel;
}
@end
