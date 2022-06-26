//
//  FJFTimerViewController.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/6/25.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import "FJFTimerViewController.h"

@interface FJFTimerViewController () {
    dispatch_source_t _sourceTimer;
}

// countTimer
@property (nonatomic, strong) NSTimer *countTimer;
// countLinkTimer
@property (nonatomic, strong) CADisplayLink *countLinkTimer;
@end

@implementation FJFTimerViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //进入后台UIApplicationDidEnterBackgroundNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [self startNormalTimer];
}

// 开启普通定时器
- (void)startNormalTimer {
    self.countTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:true
                                                        block:^(NSTimer * _Nonnull timer) {
        NSLog(@"--------------------------countDownTimer");
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

/// 开启 displayLink定时器
- (void)startDisplayLinkTimer {
    self.countLinkTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkTimerBlock)];
    [self.countLinkTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

/// 开启gcd定时器
- (void)startGcdTimer {
    // 队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    // 创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    // 设置时间
    dispatch_source_set_timer(timer,
                              dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC),
                              1 * NSEC_PER_SEC, 0);


    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"--------------------------countDownTimer");
    });

    // 启动定时器
    dispatch_resume(timer);
    _sourceTimer = timer;
}

/// 开启当前runloop监听
- (void)startCurRunloopMonitor {
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopObserverRef observer;

    observer = CFRunLoopObserverCreate(CFAllocatorGetDefault(),
                                       kCFRunLoopAllActivities,
                                       true,      // repeat
                                       0xFFFFFF,  // after CATransaction(2000000)
                                       YYRunLoopObserverCallBack, NULL);
    CFRunLoopAddObserver(runloop, observer, kCFRunLoopCommonModes);
    CFRelease(observer);
}


static void YYRunLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"----------CFRunLoopActivity: 进入runloop");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"----------CFRunLoopActivity: 即将处理Timer");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"----------CFRunLoopActivity: 即将进入休眠");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"----------CFRunLoopActivity: 从休眠中唤醒");
            break;
        case kCFRunLoopExit:
            NSLog(@"----------CFRunLoopActivity: 退出当前runloop");
            break;
        default:
            break;
    }
}

#pragma mark - Noti Methods
- (void)didEnterBackground {
    NSLog(@"--------------------------didEnterBackground");
    [[NSRunLoop mainRunLoop] run];
}

#pragma mark - Response Event
- (void)linkTimerBlock {
    NSLog(@"--------------------------countDownTimer");
}
@end
