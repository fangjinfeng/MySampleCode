
//
//  FJCustomDialogView.m
//  QNIntelligentRobot
//
//  Created by fjf on 2018/3/8.
//  Copyright © 2018年 QNIntelligentRobot. All rights reserved.
//


// tool
#import "FJFCustomPopMenuStytle.h"

// view
#import "FJFCustomPopMenuView.h"
#import "FJFCustomPopMenuIndicateView.h"



@interface FJFCustomPopMenuView()
// 容器 view
@property (nonatomic, strong) UIView *containerView;
// 容器 内容 view
@property (nonatomic, strong) UIView *containerContentView;
// 背景 按键
@property (nonatomic, strong) UIButton *backgroundButton;
// 显示 位置
@property (nonatomic, assign) CGPoint  showPosition;
// 三角型 trangleShapeLayer
@property (nonatomic, strong) FJFCustomPopMenuIndicateView *trangleView;
@end

@implementation FJFCustomPopMenuView

#pragma mark --------------- Life Circle

- (instancetype)init {
    return [self initWithFrame:[UIScreen mainScreen].bounds];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
        [self updateViewControls];
        
    }
    return self;
}



#pragma mark -------------------------- Public Methods

// 添加 子视图 到 容器 view
- (void)addSubViewToContainerContentView:(UIView *)subView {
    if (subView) {
        subView.frame = self.containerContentView.bounds;
        [self.containerContentView addSubview:subView];
    }
}

// 容器 内容 视图 viewBounds
- (CGRect)containerContentViewBounds {
    return self.containerContentView.bounds;
}

// 显示
- (void)showFromParentView:(UIView *)parentView position:(CGPoint)position {
    NSAssert([parentView isKindOfClass:[UIView class]], @"parentView 务必是UIView 类型");
    self.frame = parentView.bounds;
    self.backgroundButton.frame = self.bounds;
    
    self.showPosition = position;
    [parentView addSubview:self];
    [self updateViewControls];
    [self layoutIfNeeded];
    
    // 无动画
    if (_customDialogStyle.animateHideType == FJFCustomMenuAnimateTypeFromTop) {
        CGRect tmpFrame = self.containerView.frame;
        tmpFrame.size.height = 0;
        self.containerView.frame = tmpFrame;
        [UIView animateWithDuration:_customDialogStyle.animateDuration animations:^{
             CGRect tmpFrame = self.containerView.frame;
            tmpFrame.size.height = _customDialogStyle.containerViewHeight;
            self.containerView.frame = tmpFrame;
            [self layoutIfNeeded];
        }];
    }
    
}


- (void)dimissView {
    // 无动画
    if (_customDialogStyle.animateHideType == FJFCustomMenuAnimateTypeNone) {
        [self removeFromSuperview];
    }
    //
    else if (_customDialogStyle.animateHideType == FJFCustomMenuAnimateTypeFromTop) {
        [UIView animateWithDuration:_customDialogStyle.animateDuration animations:^{
            CGRect tmpFrame = self.containerView.frame;
            tmpFrame.size.height = 0;
            self.containerView.frame = tmpFrame;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
             [self removeFromSuperview];
        }];
    }
    
    
 
}


#pragma mark --------------- Response Event

// 背景 按键 点击
- (void)backgroundButtonClicked:(UIButton *)sender {
    if (_customDialogStyle.enableOfBackgroundButton) {
        [self dimissView];
    }
    
    if (self.backButtonClickedBlock) {
        self.backButtonClickedBlock(sender, self);
    }
}

#pragma mark --------------- Private Methods

- (void)setupViewControls {
    [self addSubview:self.backgroundButton];
    [self addSubview:self.containerView];
    
    [self.containerView addSubview:self.trangleView];
    [self.containerView addSubview:self.containerContentView];
    
    self.backgroundColor = [UIColor clearColor];
    _customDialogStyle = [[FJFCustomPopMenuStytle alloc] init];
}

// 更新 控件
- (void)updateViewControls {
    if (_customDialogStyle) {
        // 设置 背景色
        self.backgroundButton.backgroundColor = _customDialogStyle.menuViewBackgroundColor;
        
        // 容器
        CGFloat containerViewX = _customDialogStyle.containerViewLeftSpacing;
        CGFloat containerViewY = self.showPosition.y;
        CGFloat containerViewWidth =  self.frame.size.width - containerViewX - _customDialogStyle.containerViewRightSpacing;
        if (containerViewWidth < 0) {
            containerViewWidth = 0;
        }
        CGFloat containerViewHeight = _customDialogStyle.containerViewHeight;
        self.containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewWidth, containerViewHeight);
        self.containerView.backgroundColor = _customDialogStyle.containerViewBackgroundColor;
    
        
        // 指示器
        CGFloat indicateViewWidth = _customDialogStyle.indicateViewWidth;
        CGFloat indicateViewX = self.showPosition.x - (indicateViewWidth/2.0) - containerViewX;
        if (indicateViewX < 0) {
            indicateViewX = 0;
        }
        CGFloat indicateViewY = _customDialogStyle.indicateViewTopSpacing;
        CGFloat indicateViewHeight = _customDialogStyle.indicateViewHeight;
        self.trangleView.frame = CGRectMake(indicateViewX, indicateViewY, indicateViewWidth, indicateViewHeight);
        self.trangleView.fillColor = _customDialogStyle.indicateViewColor;
        [self.trangleView updateViewControls];
        
        // 容器 内容 视图
        CGFloat containerContentViewX = 0;
        CGFloat containerContentViewY = CGRectGetMaxY(self.trangleView.frame);
        CGFloat containerContentViewWidth = containerViewWidth;
        CGFloat containerContentViewHeight = _customDialogStyle.containerContentViewHeight;
        self.containerContentView.frame = CGRectMake(containerContentViewX, containerContentViewY, containerContentViewWidth, containerContentViewHeight);
        self.containerContentView.backgroundColor = _customDialogStyle.containerContentViewBackgroundColor;
    }
}


#pragma mark --------------- Getter / Setter

- (void)setCustomDialogStyle:(FJFCustomPopMenuStytle *)customDialogStyle {
    _customDialogStyle = customDialogStyle;
    if (_customDialogStyle) {
        [self updateViewControls];
    }
}


// 背景 按键
- (UIButton *)backgroundButton {
    if(!_backgroundButton){
        _backgroundButton = [[UIButton alloc] init];
        _backgroundButton.backgroundColor = [UIColor clearColor];
        [_backgroundButton addTarget:self action:@selector(backgroundButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _backgroundButton;
}

// 三角型
- (FJFCustomPopMenuIndicateView *)trangleView {
    if (!_trangleView) {
        _trangleView = [[FJFCustomPopMenuIndicateView alloc] initWithFrame:CGRectMake(0, 0, 12.0f, 8.0f)];
    }
    return _trangleView;
}

// 容器 内容
- (UIView *)containerContentView {
    if(!_containerContentView){
        _containerContentView = [[UIView alloc] init];
    }
    return  _containerContentView;
}


// 容器
- (UIView *)containerView {
    if(!_containerView){
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.clipsToBounds = YES;
    }
    return  _containerView;
}

@end
