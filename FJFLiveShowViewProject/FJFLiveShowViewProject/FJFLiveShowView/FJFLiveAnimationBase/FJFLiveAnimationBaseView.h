//
//  FJFLiveAnimationBaseView.h
//  FJFLiveShowViewProject
//
//  Created by macmini on 8/20/20.
//  Copyright © 2020 LFC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJFLiveAnimationBase.h"
#import "FJFLiveAnimationBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FJFLiveAnimationBaseView : UIView
// 视图创建时间
@property (nonatomic ,copy) NSDate * creatDate;
// 索引
@property (nonatomic ,assign) NSInteger index;
// 超时移除时长
@property (nonatomic, assign) NSInteger kTimeOut;
// 视图尺寸
@property (nonatomic, assign) CGSize  baseViewSize;
// 移除动画时长
@property (nonatomic, assign) CGFloat kRemoveAnimationTime;
// 数字改变动画时长
@property (nonatomic, assign) CGFloat kNumberAnimationTime;
// 是否正处于动画，用于视图正在向右飞出时不要交换位置
@property (nonatomic ,assign) BOOL isLeavingAnimation;
// 是否正处于动画，用于出现动画时和交换位置的动画冲突
@property (nonatomic, assign) BOOL isAppearAnimation;
// 数据源
@property (nonatomic ,strong) FJFLiveAnimationBaseModel *liveModel;
// 隐藏模式
@property (nonatomic, assign) FJFLiveAnimationHiddenMode hiddenModel;
// 动画 显示 回调
@property (nonatomic ,copy) void(^animationViewShowTimeOut)(FJFLiveAnimationBaseView *animationView);


/// 移除 视图
- (void)dimssView;

/// 开始 定时器
- (void)startTimer;

/// 停止 定时器
- (void)stopTimer;

// 重置 定时器
- (void)resetTimer;

/// 更新 显示 模型
/// @param liveModel 显示 模型
- (void)updateControlsWithLiveModel:(FJFLiveAnimationBaseModel *)liveModel;
@end

NS_ASSUME_NONNULL_END
