//
//  FJFSuspensionManager.h
//  FJFNSEnginerProject
//
//  Created by macmini on 2020/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJFSuspensionManager : NSObject

///  单例 
+ (instancetype)sharedManager;

/// 显示 悬浮窗
- (void)showSuspensionView;
@end

NS_ASSUME_NONNULL_END
