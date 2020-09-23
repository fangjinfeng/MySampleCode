//
//  NSObject+PerformTimer.h
//  FJFGlobalTimerManager
//
//  Created by macmini on 16/09/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 对象倒计时回调block

 @param receiver 回调对象
 @param remainingTime 剩余时间
 @param isStop 是否停止倒计时
 */
typedef void(^FJFObjectCountDownCallBack)(id receiver, NSInteger remainingTime, BOOL *isStop);


@interface NSObject (PerformTimer)

/**
 停止倒计时任务
 */
- (void)fjf_stopCountDown;


/**
 注册 倒计时 任务

 @param remainingTime 倒计时长
 @param timerCallBack 倒计时回调
 */
- (void)fjf_registerWithRemainingTime:(NSUInteger)remainingTime
                        timerCallBack:(FJFObjectCountDownCallBack)timerCallBack;
@end

NS_ASSUME_NONNULL_END
