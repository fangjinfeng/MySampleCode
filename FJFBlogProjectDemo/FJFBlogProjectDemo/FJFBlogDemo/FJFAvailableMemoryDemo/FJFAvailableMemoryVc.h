//
//  FJFAvailableMemoryVc.h
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/3/28.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJFAvailableMemoryVc : UIViewController
// 获取 可用 内存
+ (double)availableMemory;
// 改变
@property (nonatomic, copy) void (^changeHandler) (void);
@end

NS_ASSUME_NONNULL_END
