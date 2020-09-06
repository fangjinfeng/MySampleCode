//
//  FJFGlobalTimerManager.m
//  FJFGlobalTimerManager
//
//  Created by macmini on 15/09/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJFGlobalTimerManager.h"

#ifndef fjf_unusually
#define fjf_unusually(exp) ((typeof(exp))__builtin_expect((long)(exp), 0l))
#endif

#define fjf_signal(sema) dispatch_semaphore_signal(sema);
#define fjf_wait(sema) dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

// key 前缀
static const NSString *kFJFGlobalTimerReceiverPrefix = @"kFJFGlobalTimerReceiverPrefix";

@implementation FJFTimerReceiverModel
+ (FJFTimerReceiverModel *)receiverModelWithReceiver:(id)receiver
                                       remainingTime:(NSUInteger)remainingTime
                                      timerCallBack:(FJFTimerCallback)timerCallBack {
    FJFTimerReceiverModel *tmpModel = [[FJFTimerReceiverModel alloc] init];
    tmpModel.recevier = receiver;
    tmpModel.remainingTime = remainingTime;
    tmpModel.timerCallBack = [timerCallBack copy];
    return tmpModel;
}
@end

@interface FJFGlobalTimerManager()
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) dispatch_semaphore_t lock;
@property (nonatomic, strong) dispatch_queue_t timerQueue;
@property (nonatomic, strong) NSDate *enterBackgroundTime;
@property (nonatomic, strong) NSHashTable *receiverTable;
@property (nonatomic, strong) NSMutableDictionary <NSString *, FJFTimerReceiverModel *>*receiverMdict;
@end

@implementation FJFGlobalTimerManager
#pragma mark - Life Circle
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        _receiverTable = [NSHashTable weakObjectsHashTable];
        _receiverMdict = [NSMutableDictionary dictionary];
        self.lock = dispatch_semaphore_create(1);
        self.timerQueue = dispatch_queue_create("com.globalTimerManager.queue", DISPATCH_QUEUE_SERIAL);
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(applicationDidBecameActive:) name: UIApplicationDidBecomeActiveNotification object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(applicationDidEnterBackground:) name: UIApplicationDidEnterBackgroundNotification object: nil];
    }
    return self;
}

#pragma mark -  Public Methods
+ (instancetype)timerManager {
    static FJFGlobalTimerManager *timerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timerManager = [[FJFGlobalTimerManager alloc] init];
    });
    return timerManager;
}


- (void)registerWithReceiver:(id)receiver
               remainingTime:(NSUInteger)remainingTime
              timerCallBack:(FJFTimerCallback)timerCallBack {
    
    if (timerCallBack == nil || receiver <= 0 || receiver == nil) { return; }
    
    fjf_wait(self.lock);
    FJFTimerReceiverModel *tmpModel = [FJFTimerReceiverModel receiverModelWithReceiver:receiver remainingTime:remainingTime timerCallBack:timerCallBack];
    [self addReceiver:receiver timerModel:tmpModel];
     [self _startupTimer];
     fjf_signal(self.lock);
}




- (void)unregisterCountDownTaskWithReceiver: (id)receiver {
    if (receiver == nil) return;
    fjf_wait(self.lock);
    [self removeReceiver:receiver];
    fjf_signal(self.lock);
}


- (void)unregisterAllCountDownTask {
    
    if (self.receiverMdict.count == 0) return;
    
    fjf_wait(self.lock);
    [self _stopTimer];
    [self.receiverMdict removeAllObjects];
    [self.receiverTable removeAllObjects];
    fjf_wait(self.lock);
}

#pragma mark - Override Methods
-(id)copyWithZone:(struct _NSZone *)zone {
    return [FJFGlobalTimerManager timerManager];
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    return [FJFGlobalTimerManager timerManager];
}


#pragma mark - Noti Methods
- (void)applicationDidBecameActive: (NSNotification *)notif {
    if (self.enterBackgroundTime && self.timer) {
        long delay = [[NSDate date] timeIntervalSinceDate: self.enterBackgroundTime];
        
        dispatch_suspend(self.timer);
        [self _countDownWithInterval: delay];
        dispatch_resume(self.timer);
    }
}

- (void)applicationDidEnterBackground: (NSNotification *)notif {
    self.enterBackgroundTime = [NSDate date];
}


#pragma mark - Private Methods

- (NSString *)keyWithReceiver:(id)receiver {
    return [NSString stringWithFormat:@"%p-%p",kFJFGlobalTimerReceiverPrefix, receiver];
}


- (void)_startupTimer {
    if (self.timer != nil) { return; }
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.timerQueue);
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW + 1.0 * NSEC_PER_SEC, 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        [[FJFGlobalTimerManager timerManager] _countDownWithInterval: 1];
    });
    dispatch_resume(self.timer);
}

- (void)_stopTimer {
    if (_timer) {
        dispatch_cancel(_timer);
        _timer = nil;
    }
}

- (void)_suspendTimer {
    if (_timer) {
        dispatch_suspend(_timer);
    }
}


- (void)_countDownWithInterval: (unsigned long)interval {
    __block unsigned long count = 0;
     fjf_wait(self.lock);
    [self.receiverMdict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, FJFTimerReceiverModel * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.remainingTime < interval) {
            obj.remainingTime = 0;
        } else {
            obj.remainingTime -= interval;
        }
        count++;
    }];
    fjf_signal(self.lock);
    if (count == 0) {
        [self _stopTimer];
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        fjf_wait(self.lock);
        [self.receiverMdict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, FJFTimerReceiverModel * _Nonnull obj, BOOL * _Nonnull stop) {
            bool isStop = false;
            if (fjf_unusually((isStop == true))) {
                obj.remainingTime = 0;
            }
            
            if (obj.remainingTime == 0) {
                obj.timerCallBack(obj.remainingTime, &isStop);
            }
        }];
        fjf_signal(self.lock);
        
        dispatch_async(self->_timerQueue, ^{
            fjf_wait(self.lock);
            NSDictionary *tmpDict = [NSDictionary dictionaryWithDictionary:self.receiverMdict];
            [tmpDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, FJFTimerReceiverModel * _Nonnull obj, BOOL * _Nonnull stop) {
                if (obj.remainingTime <= 0) {
                    [self removeReceiver:obj.recevier];
                }
                
                if ([self.receiverTable containsObject:obj.recevier] == NO &&
                    [self.receiverMdict objectForKey:key]) {
                    [self.receiverMdict removeObjectForKey:key];
                }
            }];
             fjf_signal(self.lock);
        });
    });
}

- (void)addReceiver:(id)receiver timerModel:(FJFTimerReceiverModel *)timerModel{
   if (receiver == nil || timerModel == nil) return;
    
    NSString *tmpKey = [self keyWithReceiver:receiver];
    [_receiverTable addObject:receiver];
    [_receiverMdict setObject:timerModel forKey:tmpKey];

}
- (void)removeReceiver:(id)receiver {
    if (receiver == nil) return;
    NSString *tmpKey = [self keyWithReceiver:receiver];
    [_receiverTable removeObject:receiver];
    [_receiverMdict removeObjectForKey:tmpKey];
}
@end
