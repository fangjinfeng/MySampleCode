//
//  FJFGlobalTimerManager.h
//  FJFGlobalTimerManager
//
//  Created by macmini on 15/09/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 回调block

 @param remainingTime  倒计时剩余秒数
 @param isStop 是否停止倒计时
 */
typedef void(^FJFTimerCallback)(long remainingTime, bool *isStop);


@interface FJFTimerReceiverModel : NSObject
// recevier
@property (nonatomic, weak) id recevier;
// remainingTime
@property (nonatomic, assign) NSUInteger  remainingTime;
// timerCallBack
@property (nonatomic, copy) FJFTimerCallback timerCallBack;

+ (FJFTimerReceiverModel *)receiverModelWithReceiver:(id)receiver
                                       remainingTime:(NSUInteger)remainingTime
                                      timerCallBack:(FJFTimerCallback)timerCallBack;
@end


@interface FJFGlobalTimerManager : NSObject

/**
 获取定时器管理对象

 @return 定时器管理对象
 */
+ (instancetype)timerManager;

/**
 取消所有倒计时任务
 */
- (void)unregisterAllCountDownTask;

/**
 取消倒计时任务注册

 @param receiver 注册的对象
 */
- (void)unregisterCountDownTaskWithReceiver: (id)receiver;
/**
 注册倒计时回调

 @param receiver 注册的对象
 @param remainingTime 倒计时长
 @param timerCallBack 回调block
 */
- (void)registerWithReceiver:(id)receiver
               remainingTime:(NSUInteger)remainingTime
              timerCallBack:(FJFTimerCallback)timerCallBack;
@end

NS_ASSUME_NONNULL_END
