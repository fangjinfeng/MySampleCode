
//
//  FJFIndicatorTriangleBorderView.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 08/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//


#import "FJFIndicatorTriangleBorderView.h"

@implementation FJFIndicatorTriangleBorderViewStyle
#pragma mark - Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _contentViewCornerRadius = 4.0f;
        _contentViewBorderWidth = 1.0f;
        _contentViewBorderColor = [UIColor redColor];
        _contentViewFillColor = [UIColor whiteColor];
        _indicatorTriangleViewType = FJFIndicatorTriangleViewTypeTop;
        _indicatorTriangleViewWidth = 20.0f;
        _indicatorTriangleViewHeight = 16.0f;
        _indicatorTriangleViewOffset = 20.0f;
    }
    return self;
}
@end


@interface FJFIndicatorTriangleBorderView()
// contentView
@property (nonatomic, strong) UIView *contentView;
// indicatorTriangleView
@property (nonatomic, strong) FJFIndicatorTriangleView *indicatorTriangleView;
// viewStyle
@property (nonatomic, strong) FJFIndicatorTriangleBorderViewStyle *viewStyle;
@end


@implementation FJFIndicatorTriangleBorderView
#pragma mark - Life Circle

- (instancetype)initWithFrame:(CGRect)frame {
    
    return [self initWithFrame:frame viewStyle:[[FJFIndicatorTriangleBorderViewStyle alloc] init]];
}

- (instancetype)initWithFrame:(CGRect)frame
                    viewStyle:(FJFIndicatorTriangleBorderViewStyle *)viewStyle{
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
        [self updateViewStyle:viewStyle];
    }
    return self;
}

#pragma mark - Public Methods
// 更新 viewStyle
- (void)updateViewStyle:(FJFIndicatorTriangleBorderViewStyle *)viewStyle {
    _viewStyle = viewStyle;
    if (viewStyle) {
        [self updateViewControls];
    }
}

// 更新 控件
- (void)updateViewControls {
   
    self.contentView.layer.cornerRadius = _viewStyle.contentViewCornerRadius;
    self.contentView.layer.borderColor = _viewStyle.contentViewBorderColor.CGColor;
    self.contentView.layer.borderWidth = _viewStyle.contentViewBorderWidth;
    self.contentView.frame = [self contentViewFrame];
    self.contentView.backgroundColor = _viewStyle.contentViewFillColor;
    
    self.indicatorTriangleView.frame = [self indicatorTriangleViewFrame];
    self.indicatorTriangleView.triangleViewType = _viewStyle.indicatorTriangleViewType;
    [self.indicatorTriangleView updateFillColor:_viewStyle.contentViewFillColor];
    [self.indicatorTriangleView updateStrokeColor:_viewStyle.contentViewBorderColor];
    [self.indicatorTriangleView updateLineWidth:_viewStyle.contentViewBorderWidth];
    [self.indicatorTriangleView updateViewControls];
}

#pragma mark - Private Methods

- (void)setupViewControls {
    [self addSubview:self.contentView];
    [self addSubview:self.indicatorTriangleView];
}

// indicatorTriangleView 位置
- (CGRect)indicatorTriangleViewFrame {
    CGFloat viewX = 0;
    CGFloat viewY = 0;
    CGFloat viewOffset = _viewStyle.contentViewBorderWidth;
    CGFloat viewWidth = 0;
    CGFloat viewHeight = 0;
    switch (_viewStyle.indicatorTriangleViewType) {
            // 上
        case FJFIndicatorTriangleViewTypeTop:
            viewX = _viewStyle.indicatorTriangleViewOffset;
            viewY = 0;
            viewWidth = _viewStyle.indicatorTriangleViewWidth;
            viewHeight = _viewStyle.indicatorTriangleViewHeight + viewOffset;
            break;
            // 下
        case FJFIndicatorTriangleViewTypeBottom:
            viewX = _viewStyle.indicatorTriangleViewOffset;
            viewY = CGRectGetMaxY(self.contentView.frame) - viewOffset;
            viewWidth = _viewStyle.indicatorTriangleViewWidth;
            viewHeight = _viewStyle.indicatorTriangleViewHeight + viewOffset;
            break;
            // 左
        case FJFIndicatorTriangleViewTypeLeft:
            viewX = 0;
            viewY = _viewStyle.indicatorTriangleViewOffset;
            viewWidth = _viewStyle.indicatorTriangleViewHeight + viewOffset;
            viewHeight = _viewStyle.indicatorTriangleViewWidth;
            break;
            // 右
        case FJFIndicatorTriangleViewTypeRight:
            viewX = CGRectGetMaxX(self.contentView.frame) - viewOffset;
            viewY = _viewStyle.indicatorTriangleViewOffset;
            viewWidth = _viewStyle.indicatorTriangleViewHeight + viewOffset;
            viewHeight = _viewStyle.indicatorTriangleViewWidth;
            break;
            
        default:
            break;
    }
    return CGRectMake(viewX, viewY, viewWidth, viewHeight);
}

// contentView 位置
- (CGRect)contentViewFrame {
    CGFloat viewX = 0;
    CGFloat viewY = 0;
    CGFloat viewWidth = 0;
    CGFloat viewHeight = 0;
    switch (_viewStyle.indicatorTriangleViewType) {
            // 上
        case FJFIndicatorTriangleViewTypeTop:
            viewX = 0;
            viewY = _viewStyle.indicatorTriangleViewHeight;
            viewWidth = self.frame.size.width;
            viewHeight = self.frame.size.height - viewY;
            break;
            // 下
        case FJFIndicatorTriangleViewTypeBottom:
            viewX = 0;
            viewY = 0;
            viewWidth = self.frame.size.width;
            viewHeight = self.frame.size.height - _viewStyle.indicatorTriangleViewHeight;
            break;
            // 左
        case FJFIndicatorTriangleViewTypeLeft:
            viewX = _viewStyle.indicatorTriangleViewHeight;
            viewY = 0;
            viewWidth = self.frame.size.width - viewX;
            viewHeight = self.frame.size.height;
            break;
            // 右
        case FJFIndicatorTriangleViewTypeRight:
            viewX = 0;
            viewY = 0;
            viewWidth = self.frame.size.width - _viewStyle.indicatorTriangleViewHeight;
            viewHeight = self.frame.size.height;
            break;
            
        default:
            break;
    }
    return CGRectMake(viewX, viewY, viewWidth, viewHeight);
}

#pragma mark - Setter / Getter
// contentView
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

// 指示器
- (FJFIndicatorTriangleView *)indicatorTriangleView {
    if (!_indicatorTriangleView) {
        _indicatorTriangleView = [[FJFIndicatorTriangleView alloc] init];
    }
    return _indicatorTriangleView;
}
@end
