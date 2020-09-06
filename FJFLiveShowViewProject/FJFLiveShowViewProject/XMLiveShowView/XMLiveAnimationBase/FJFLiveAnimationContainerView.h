//
//  FJFLiveAnimationContainerView.h
//  FJFLiveShowViewProject
//
//  Created by macmini on 8/20/20.
//  Copyright © 2020 LFC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJFLiveAnimationBaseView.h"
#import "FJFLiveAnimationBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef FJFLiveAnimationBaseView* _Nonnull (^FJFLiveAnimationViewBlock)(void);

@interface FJFLiveAnimationViewStyle : NSObject
// 交换动画时长
@property(nonatomic, assign) CGFloat exchangeAnimationTime;
// 出现时动画延迟时长
@property(nonatomic, assign) CGFloat appearAnimationDeayTime;
// 出现时动画时长
@property(nonatomic, assign) CGFloat appearAnimationTime;
// 出现时动画 阻尼(0.0f到1.0f，数值越小「弹簧」的振动效果越明显)
@property(nonatomic, assign) CGFloat appearAnimationDamping;
// 出现时动画 初始速度
@property(nonatomic, assign) CGFloat appearAnimationVelocity;

// 添加模式 addModel
@property (nonatomic, assign) FJFLiveAnimationAddMode  addModel;
// 出现模式 appearModel
@property (nonatomic, assign) FJFLiveAnimationAppearMode  appearModel;
// 隐藏模式 hiddenModel
@property (nonatomic, assign) FJFLiveAnimationHiddenMode  hiddenModel;
// 展示模式 showModel
@property (nonatomic, assign) FJFLiveAnimationShowMode  showModel;
// 顶部 隐藏 模式topSqueezeModel
@property (nonatomic, assign) FJFLiveAnimationHiddenMode  topSqueezeModel;
// 最大展示数量 maxShowLiveViewCount
@property (nonatomic, assign) NSInteger  maxShowLiveViewCount;
// 最大等待数量 maxWaitLiveViewCount
@property (nonatomic, assign) NSInteger  maxWaitLiveViewCount;
// 两个动画 视图 间隔 liveViewSpacing
@property (nonatomic, assign) CGFloat  liveViewSpacing;
// 展示动画 宽度 liveViewWidth
@property (nonatomic, assign) CGFloat  liveViewWidth;
// 展示动画 高度 liveViewHeight
@property (nonatomic, assign) CGFloat  liveViewHeight;
// 展示动画 顶部间距 liveViewTopSpacing
@property (nonatomic, assign) CGFloat  liveViewTopSpacing;
@end

@interface FJFLiveAnimationContainerView : UIView
// viewStyle
@property (nonatomic, strong, readonly) FJFLiveAnimationViewStyle *viewStyle;

// liveViewBlock
@property (nonatomic, copy) FJFLiveAnimationViewBlock liveViewBlock;


/// 添加 显示 模型
/// @param showModel 显示 模型
- (void)addLiveShowModel:(FJFLiveAnimationBaseModel *)showModel;
/// 初始化 方法
/// @param frame 位置
/// @param viewStyle viewStyle
- (instancetype)initWithFrame:(CGRect)frame
                    viewStyle:(FJFLiveAnimationViewStyle *)viewStyle;
@end

NS_ASSUME_NONNULL_END
