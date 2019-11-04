//
//  FJCustomDialogStytle.h
//  FJFPopMenuViewDemo
//
//  Created by macmini on 2018/3/8.
//  Copyright © 2018年 FJFPopMenuViewDemo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, FJFCustomMenuAnimateType) {
    // 无动画
    FJFCustomMenuAnimateTypeNone = 0,
    // 从顶部 弹出
    FJFCustomMenuAnimateTypeFromTop,
};

// 指示器 位置
typedef NS_ENUM(NSUInteger, FJFCustomMenuIndicateViewPositionType) {
    // 顶部
    FJFCustomMenuIndicateViewPositionTypeTop = 0,
    // 底部
    FJFCustomMenuIndicateViewPositionTypeBottom,
};

@interface FJFCustomPopMenuStytle : NSObject
// 动画 时间
@property (nonatomic, assign) CGFloat animateDuration;
// 容器 高度 view height
@property (nonatomic, assign) CGFloat containerViewHeight;
// 指示器 宽度 indicateViewWidth
@property (nonatomic, assign) CGFloat indicateViewWidth;
// 指示器 高度 indicateViewHeight
@property (nonatomic, assign) CGFloat indicateViewHeight;
// 指示 顶部间距 topSpacing
@property (nonatomic, assign) CGFloat indicateViewTopSpacing;
// 指示器 颜色 indicateViewColor
@property (nonatomic, strong) UIColor *indicateViewColor;
// 容器 内容 视图高度 view height
@property (nonatomic, assign) CGFloat containerContentViewHeight;
// 容器 内容 视图圆角 containerContentViewCornerRadius
@property (nonatomic, assign) CGFloat containerContentViewCornerRadius;
// 容器 内容 边框宽度 containerContentViewBorderWidth
@property (nonatomic, assign) CGFloat containerContentViewBorderWidth;
// 容器 内容 边框宽度 containerContentViewBorderColor
@property (nonatomic, strong) UIColor *containerContentViewBorderColor;
// 弹框 背景颜色
@property (nonatomic, strong) UIColor *menuViewBackgroundColor;
// 容器 左边距 view left spacing
@property (nonatomic, assign) CGFloat containerViewLeftSpacing;
// 容器 右边距 view right spacing
@property (nonatomic, assign) CGFloat containerViewRightSpacing;
// 容器 边框 颜色 containerViewBackgroundShadowColor
@property (nonatomic, strong) UIColor *containerViewBackgroundShadowColor;
// 容器 宽度 containerViewWidth
// containerViewWidth 有值
// containerViewLeftSpacing containerViewRightSpacing 将会失效
@property (nonatomic, assign) CGFloat containerViewWidth;
// 指示器 偏移值
// indicateViewOffsetX 偏移值
// containerViewWidth 有效(才有效)
@property (nonatomic, assign) CGFloat indicateViewOffsetX;
// 容器 背景颜色
@property (nonatomic, strong) UIColor *containerViewBackgroundColor;
// 容器 内容 背景颜色
@property (nonatomic, strong) UIColor *containerContentViewBackgroundColor;
// 动画 类型
@property (nonatomic, assign) FJFCustomMenuAnimateType animateShowType;
// 动画 类型
@property (nonatomic, assign) FJFCustomMenuAnimateType animateHideType;
// positionType
@property (nonatomic, assign) FJFCustomMenuIndicateViewPositionType  positionType;
// 背景 按键 是否 可以 相应
@property (nonatomic, assign, getter=isEnableOfBackgroundButton) BOOL  enableOfBackgroundButton;

- (instancetype)initWithContainerViewHeight:(CGFloat)containerViewHeight ;
@end
