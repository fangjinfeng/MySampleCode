//
//  WBMonitor.m
//  CrashProject
//
//  Created by mac on 2019/7/13.
//  Copyright © 2019年 Delpan. All rights reserved.
//

#import "WBMonitor.h"
#import <mach/mach.h>
#import "BSBacktraceLogger.h"

static CFRunLoopActivity _MainRunLoopActivity = 0;
static u_int64_t _MainRunLoopFrameMark = 0;
static float _MainRunLoopMillisecondPerSecond = 1000.0;
static double _MainRunLoopBlanceMillisecondPerFrame = 16.666666;


static mach_timebase_info_data_t _MainRunLoopFrameTimeBase(void) {
    static mach_timebase_info_data_t *timebase = 0;
    
    if (!timebase) {
        timebase = malloc(sizeof(mach_timebase_info_data_t));
        mach_timebase_info(timebase);
    }
    return *timebase;
}

static void _MainRunLoopFrameCallBack(CFRunLoopActivity activity) {
    if ((activity == kCFRunLoopAfterWaiting) || (_MainRunLoopFrameMark == 0)){
        _MainRunLoopFrameMark = mach_absolute_time();
    }
    else {
        mach_timebase_info_data_t timebase = _MainRunLoopFrameTimeBase();
        u_int64_t check = mach_absolute_time();
        u_int64_t sum = (check - _MainRunLoopFrameMark) * (double)timebase.numer / (double)timebase.denom / 1e6;
        _MainRunLoopFrameMark = check;

        if (sum > _MainRunLoopBlanceMillisecondPerFrame) {
            NSInteger blanceFramePerSecond = (NSInteger)(_MainRunLoopMillisecondPerSecond - sum);
            _MainRunLoopMillisecondPerSecond = (blanceFramePerSecond > 0) ? blanceFramePerSecond : 0;
            NSLog(@"sum: %lld", sum);
            NSLog(@"_MainRunLoopMillisecondPerSecond = %ld", (long)_MainRunLoopMillisecondPerSecond);
        }
    }
}

static void _MainRunLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    _MainRunLoopActivity = activity;
//    NSLog(@"activity = %ld", activity);
    
    if (_MainRunLoopActivity == kCFRunLoopBeforeWaiting ||
        _MainRunLoopActivity == kCFRunLoopAfterWaiting) {
        _MainRunLoopFrameCallBack(activity);
    }
}

@interface WBMonitor () {
    NSRunLoop *_monitorRunLoop;
    NSInteger _count;
    BOOL _checked;
    NSInteger _frameCount;
    NSString *_dumpCatonString;
    dispatch_source_t _gcdTimer;
    NSTimer *_monitorTimer;
}

@end

@implementation WBMonitor

#pragma mark -------------------------- Public Methods

- (void)startMonitor {
    if (!_monitorRunLoop) {
        CFRunLoopObserverContext context = { 0, nil, NULL, NULL };
        CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                                kCFRunLoopAllActivities,
                                                                YES,
                                                                0,
                                                                &_MainRunLoopObserverCallBack,
                                                                &context);
        CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
        CFRelease(observer);
        [self startFpsTimer];
        [NSThread detachNewThreadSelector:@selector(monitorThreadStart) toTarget:self withObject:nil];
    }
}

- (void)stopMonitor {
    [self stopFpsTimer];
    [self stopMonitorTimer];
    CFRunLoopStop(_monitorRunLoop.getCFRunLoop);
    _monitorRunLoop = nil;
}




#pragma mark -------------------------- Response Event
- (void)timerAction:(NSTimer *)timer {
    if (_MainRunLoopActivity != kCFRunLoopBeforeWaiting) {
        if (!_checked){
            _checked = YES;
            CFRunLoopPerformBlock(CFRunLoopGetMain(), kCFRunLoopCommonModes, ^{
                self->_checked = NO;
                self->_count = 0;
            });
        }
        else {
            ++_count;
            
            if (_count == 4) {
                _dumpCatonString = [BSBacktraceLogger bs_backtraceOfMainThread];
            }
            
            if (_count > 5) {
                _count = 0;
                NSLog(@"卡住啦");
                NSString *tmpCatonString = [BSBacktraceLogger bs_backtraceOfMainThread];
                if ([_dumpCatonString isEqualToString:tmpCatonString]) {
                    NSLog(@"%@", tmpCatonString);
                }
            }
        }
    }
    else{
        _count = 0;
    }
}


#pragma mark -------------------------- Private Methods

- (void)monitorThreadStart {
    _monitorTimer = [NSTimer timerWithTimeInterval:1 / 10.f
                                             target:self
                                           selector:@selector(timerAction:)
                                           userInfo:nil
                                            repeats:YES];
    
    _monitorRunLoop = [NSRunLoop currentRunLoop];
    [_monitorRunLoop addTimer:_monitorTimer forMode:NSRunLoopCommonModes];
    
    CFRunLoopRun();
}

- (void)startFpsTimer {
    
    _gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    dispatch_source_set_timer(_gcdTimer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(_gcdTimer, ^{
        NSInteger fps = (NSInteger)(_MainRunLoopMillisecondPerSecond/_MainRunLoopBlanceMillisecondPerFrame);
        if (self.fpsBlock) {
            self.fpsBlock(fps);
        }
        _MainRunLoopMillisecondPerSecond = 1000.0;
    });
    dispatch_resume(_gcdTimer);
}


- (void)stopFpsTimer {
    if (_gcdTimer) {
        dispatch_cancel(_gcdTimer);
        _gcdTimer = nil;
    }
}

- (void)stopMonitorTimer {
    if (_monitorTimer) {
        [_monitorTimer invalidate];
        _monitorTimer = nil;
    }
}
@end

















































































