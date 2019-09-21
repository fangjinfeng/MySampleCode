//
//  FJFSystemMuteHelper.h
//  FJFSystemMuteDemo
//
//  Created by fjf on 05/09/2019.
//  Copyright © 2019 fjf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FJFSystemMuteHelperMuteSwitchBlock) (BOOL isMute);

@interface FJFSystemMuteHelper : NSObject

/**
 是否系统音量 静音

 @return 是否 静音
 */
+ (BOOL)isSystmeVolumeMute;

/**
 系统 音量

 @return 系统 音量
 */
+ (float)systemVolume;
/**
 检测 静音按键 或 系统音量 两者是否 有一个 静音

 @param muteSwitchBlock 状态 回调
 */
+ (void)detectAllSystemMuteWithMuteSwitchBlock:(FJFSystemMuteHelperMuteSwitchBlock)muteSwitchBlock;
/**
 检测 静音 按键 状态

 @param muteSwitchBlock 状态 回调
 */
+ (void)detectSystemMuteStatusWithMuteSwitchBlock:(FJFSystemMuteHelperMuteSwitchBlock)muteSwitchBlock;
@end

NS_ASSUME_NONNULL_END
