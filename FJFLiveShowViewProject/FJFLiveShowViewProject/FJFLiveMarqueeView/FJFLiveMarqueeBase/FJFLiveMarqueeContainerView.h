//
//  FJFLiveMarqueeContainerView.h
//  FJFLiveShowViewProject
//
//  Created by macmini on 9/8/20.
//  Copyright © 2020 FJFLiveShowViewProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJFLiveMarqueeBase.h"
#import "FJFLiveMarqueeBaseView.h"
#import "FJFLiveMarqueeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef FJFLiveMarqueeBaseView* _Nonnull (^FJFLiveMarqueeViewBlock)(void);

@interface FJFLiveMarqueeViewStyle : NSObject
// showMaxHeight
@property (nonatomic, assign) CGFloat showMaxHeight;
// 出现时动画时长
@property(nonatomic, assign) CGFloat appearAnimationTime;
// 展示动画 宽度 liveViewWidth
@property (nonatomic, assign) CGFloat  liveViewWidth;
// 展示动画 高度 liveViewHeight
@property (nonatomic, assign) CGFloat  liveViewHeight;
// 最大展示数量 maxShowLiveViewCount
@property (nonatomic, assign) NSInteger  maxShowLiveViewCount;
// 最大等待数量 maxWaitLiveViewCount
@property (nonatomic, assign) NSInteger  maxWaitLiveViewCount;
// 出现模式 appearModel
@property (nonatomic, assign) FJFLiveMarqueeAppearMode  appearModel;
// 跑马灯 位置 marqueePositionType
@property (nonatomic, assign) FJFLiveMarqueePositionType  marqueePositionType;
@end

@interface FJFLiveMarqueeContainerView : UIView
// viewStyle
@property (nonatomic, strong, readonly) FJFLiveMarqueeViewStyle *viewStyle;

// marqueeViewBlock
@property (nonatomic, copy) FJFLiveMarqueeViewBlock marqueeViewBlock;

/// 动画 回调
@property (nonatomic, copy) void (^appearAnimationBlock)(FJFLiveMarqueeContainerView *containerView, FJFLiveMarqueeBaseView *showView, FJFLiveMarqueeViewStyle *viewStyle);

/// 添加 显示 模型
/// @param marqueeModel 跑马灯 模型
- (void)addMarqueeModel:(FJFLiveMarqueeBaseModel *)marqueeModel;
/// 初始化 方法
/// @param frame 位置
/// @param viewStyle viewStyle
- (instancetype)initWithFrame:(CGRect)frame
                    viewStyle:(FJFLiveMarqueeViewStyle *)viewStyle;

/// 移除 当前 显示 view
/// @param showView 显示view
- (void)removeCurrentShowViewWithShowView:(FJFLiveMarqueeBaseView *)showView;
@end
NS_ASSUME_NONNULL_END
