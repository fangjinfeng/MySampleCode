//
//  WBMonitor.h
//  CrashProject
//
//  Created by mac on 2019/7/13.
//  Copyright © 2019年 Delpan. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^WBMonitorBlock) (NSInteger fps);

@interface WBMonitor : NSObject

// fpsBlock
@property (nonatomic, copy) WBMonitorBlock fpsBlock;


/**
 开始 监听
 */
- (void)startMonitor;


/**
 停止 监听
 */
- (void)stopMonitor;
@end

















































































