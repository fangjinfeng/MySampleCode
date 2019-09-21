//
//  FJFMonitor.m
//  FJFCatonDetectionTool
//
//  Created by 方金峰 on 2019/8/20.
//  Copyright © 2019 方金峰. All rights reserved.
//

#import "FJFMonitor.h"

@interface FJFMonitor() {
    dispatch_semaphore_t _semaphore;
    CFRunLoopActivity _activity;
    NSInteger _timeoutCount;
}
@end
@implementation FJFMonitor

- (void)startMonitor {
    [self registerObserver];
}


- (void)registerObserver {
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                            kCFRunLoopAllActivities,
                                                            YES,
                                                            0,
                                                            &runLoopObserverCallBack,
                                                            &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    
    // 创建信号
    _semaphore = dispatch_semaphore_create(0);
    
    // 在子线程监控时长
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES) {
            // 假定连续5次超时50ms认为卡顿(当然也包含了单次超时250ms)
            long st = dispatch_semaphore_wait(self->_semaphore, dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC));
            if (st != 0) {
                if (self->_activity == kCFRunLoopBeforeSources || self->_activity==kCFRunLoopAfterWaiting) {
                    if (++self->_timeoutCount < 5)
                        continue;
                    
                    NSLog(@"好像有点儿卡哦");
                }
            }
            self->_timeoutCount = 0;
        }
    });
}

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    FJFMonitor *moniotr = (__bridge FJFMonitor*)info;
    
    // 记录状态值
    moniotr->_activity = activity;
    
    // 发送信号
    dispatch_semaphore_t semaphore = moniotr->_semaphore;
    dispatch_semaphore_signal(semaphore);
}
@end
