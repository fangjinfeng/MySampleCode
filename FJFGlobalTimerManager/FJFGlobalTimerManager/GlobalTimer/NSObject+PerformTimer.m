//
//  NSObject+PerformTimer.m
//  FJFGlobalTimerManager
//
//  Created by fjf on 16/09/2019.
//  Copyright © 2019 fjf. All rights reserved.
//

#import "NSObject+PerformTimer.h"
#import "FJFGlobalTimerManager.h"

@implementation NSObject (PerformTimer)

- (void)fjf_registerWithRemainingTime:(NSUInteger)remainingTime
                    timerCallBack:(FJFObjectCountDownCallBack)timerCallBack {
    
    if (timerCallBack == nil || remainingTime <= 0) { return; }
    __weak typeof(self) weakSelf = self;
    [[FJFGlobalTimerManager timerManager] registerWithReceiver:self remainingTime:remainingTime timerCallBack:^(long leftTime, bool * _Nonnull isStop) {
        if (weakSelf) {
            timerCallBack(weakSelf, leftTime, (BOOL *)isStop);
        } else {
            *isStop = YES;
        }
    }];
}

- (void)fjf_stopCountDown {
    [[FJFGlobalTimerManager timerManager] unregisterCountDownTaskWithReceiver:self];
}
@end
