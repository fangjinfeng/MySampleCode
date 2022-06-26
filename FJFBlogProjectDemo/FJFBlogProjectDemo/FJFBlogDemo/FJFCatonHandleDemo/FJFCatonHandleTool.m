//
//  FJFCatonHandleTool.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/6/9.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import "FJFCatonHandleTool.h"

@interface FJFCatonHandleTool() {
    CFRunLoopObserverRef _observer;
}
/// 任务数组
@property (nonatomic,strong) NSMutableArray * taskMarray;
@end

@implementation FJFCatonHandleTool
- (instancetype)init {
    self = [super init];
    if (self) {
        //初始化对象／基本信息
        self.taskMarray = [NSMutableArray array];
        //添加Runloop观察者
        [self addRunloopObserver];
    }
    return self;
}

#pragma mark - Public Methods
/// 添加任务
- (void)addTask:(FJFRunloopBlock)task {
    [self.taskMarray addObject:task];
}

#pragma mark - Private Methods
//添加runloop监听者
- (void)addRunloopObserver{
    
    //    获取 当前的Runloop ref - 指针
    CFRunLoopRef current =  CFRunLoopGetCurrent();
    
    
    //上下文
    /*
     typedef struct {
        CFIndex    version; //版本号 long
        void *    info;    //这里我们要填写对象（self或者传进来的对象）
        const void *(*retain)(const void *info);        //填写&CFRetain
        void    (*release)(const void *info);           //填写&CGFRelease
        CFStringRef    (*copyDescription)(const void *info); //NULL
     } CFRunLoopObserverContext;
     */
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    
    /*
     1 NULL空指针 nil空对象 这里填写NULL
     2 模式
        kCFRunLoopEntry = (1UL << 0),
        kCFRunLoopBeforeTimers = (1UL << 1),
        kCFRunLoopBeforeSources = (1UL << 2),
        kCFRunLoopBeforeWaiting = (1UL << 5),
        kCFRunLoopAfterWaiting = (1UL << 6),
        kCFRunLoopExit = (1UL << 7),
        kCFRunLoopAllActivities = 0x0FFFFFFFU
     3 是否重复 - YES
     4 nil 或者 NSIntegerMax - 999
     5 回调
     6 上下文
     */
    //    创建观察者
    _observer = CFRunLoopObserverCreate(NULL,
                                                  kCFRunLoopBeforeWaiting | kCFRunLoopExit, YES,
                                                  NSIntegerMax - 999,
                                                  &kFJFRunloopCallback,
                                                  &context);
    
    //添加当前runloop的观察着
    CFRunLoopAddObserver(current, _observer, kCFRunLoopCommonModes);
}


- (void)endMonitor {
    if (!_observer) {
        return;
    }
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    CFRelease(_observer);
    _observer = NULL;
}

//这里处理耗时操作了
static void kFJFRunloopCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    //通过info桥接为当前的对象
    FJFCatonHandleTool * runloop = (__bridge FJFCatonHandleTool *)info;
    
    //如果没有任务，就直接返回
    if (runloop.taskMarray.count == 0) {
        [runloop endMonitor];
        return;
    }
    
    //取出任务
    FJFRunloopBlock unit = runloop.taskMarray.firstObject;
    
    //执行任务
    unit();
    
    //删除任务
    [runloop.taskMarray removeObject:unit];
}
@end
