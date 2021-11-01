//
//  FJFPermanentThread.m
//  FJFBlogProjectDemo
//
//  Created by fjf on 2021/10/8.
//  Copyright © 2021 fjf. All rights reserved.
//

#import "FJFPermanentThread.h"

@implementation FJFPermanentThread {
    NSMutableArray *_actionMarray;
    NSThread *_thread;
    dispatch_semaphore_t _semaphore;
    dispatch_semaphore_t _arraySemaphore;
    bool _cancel;
}


#pragma mark - Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _actionMarray = [NSMutableArray array];
        
        // 创建 信号量
        _semaphore = dispatch_semaphore_create(0);
        // 保证 数组 操作 原子性
        _arraySemaphore = dispatch_semaphore_create(1);
        
        // 创建 线程
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(handleMessage) object:nil];
        [_thread start];
    }
    return self;
}

#pragma mark - Public Methods
-(void)doAction:(dispatch_block_t)action {
    if (!_cancel) {
        // 将任务 放入数组
        [self actionMarryAddObject:[action copy]];
        // 信号量 加1
        dispatch_semaphore_signal(_semaphore);
    }
}

- (void)cancel {
    _cancel = YES;
    // 线程 取消后,清空所有回调
    [self actionMarryRemoveAllObject];
    // 相当于 发送一个 任务终止 信号
    dispatch_semaphore_signal(_semaphore);
}

#pragma mark - Private Methods
// 处理 消息
- (void)handleMessage {
    while (true) {
        // 等待信号量,信号量减1
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        
        // 收到信号
        if (_cancel) {
            break;
        }
        
        // 开始执行任务
        dispatch_block_t block = [self actionMarryFirstObject];
        if (block) {
            block();
            [self actionMarryRemoveObject:block];
        }
        
    }
}

- (void)actionMarryAddObject:(id)object {
    dispatch_semaphore_wait(_arraySemaphore, DISPATCH_TIME_FOREVER);
    [_actionMarray addObject:object];
    dispatch_semaphore_signal(_arraySemaphore);
}

- (void)actionMarryRemoveObject:(id)object {
    dispatch_semaphore_wait(_arraySemaphore, DISPATCH_TIME_FOREVER);
    [_actionMarray removeObject:object];
    dispatch_semaphore_signal(_arraySemaphore);
}

- (void)actionMarryRemoveAllObject {
    dispatch_semaphore_wait(_arraySemaphore, DISPATCH_TIME_FOREVER);
    [_actionMarray removeAllObjects];
    dispatch_semaphore_signal(_arraySemaphore);
}

- (dispatch_block_t)actionMarryFirstObject {
    dispatch_semaphore_wait(_arraySemaphore, DISPATCH_TIME_FOREVER);
    dispatch_block_t block = [_actionMarray firstObject];
    dispatch_semaphore_signal(_arraySemaphore);
    return block;
}
@end
