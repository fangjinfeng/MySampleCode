//
//  FJCustomDialogStytle.h
//  QNIntelligentRobot
//
//  Created by fjf on 2018/3/8.
//  Copyright © 2018年 QNIntelligentRobot. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, FJFCustomMenuAnimateType) {
    // 无动画
    FJFCustomMenuAnimateTypeNone = 0,
    // 从顶部 弹出
    FJFCustomMenuAnimateTypeFromTop,
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
// 弹框 背景颜色
@property (nonatomic, strong) UIColor *menuViewBackgroundColor;
// 容器 左边距 view left spacing
@property (nonatomic, assign) CGFloat containerViewLeftSpacing;
// 容器 右边距 view right spacing
@property (nonatomic, assign) CGFloat containerViewRightSpacing;
// 容器 背景颜色
@property (nonatomic, strong) UIColor *containerViewBackgroundColor;
// 容器 内容 背景颜色
@property (nonatomic, strong) UIColor *containerContentViewBackgroundColor;
// 动画 类型
@property (nonatomic, assign) FJFCustomMenuAnimateType animateShowType;
// 动画 类型
@property (nonatomic, assign) FJFCustomMenuAnimateType animateHideType;
// 背景 按键 是否 可以 相应
@property (nonatomic, assign, getter=isEnableOfBackgroundButton) BOOL  enableOfBackgroundButton;
@end
