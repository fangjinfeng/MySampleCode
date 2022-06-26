//
//  FJFCatonHandleTool.h
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/6/9.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FJFRunloopBlock)(void);

@interface FJFCatonHandleTool : NSObject
/// 结束监听
- (void)endMonitor;
/// 添加任务
- (void)addTask:(FJFRunloopBlock)task;
@end

NS_ASSUME_NONNULL_END
