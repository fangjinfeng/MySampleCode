//
//  FJFLiveAnimationBase.h
//  FJFLiveShowViewProject
//
//  Created by macmini on 8/20/20.
//  Copyright © 2020 LFC. All rights reserved.
//

#ifndef FJFLiveAnimationBase_h
#define FJFLiveAnimationBase_h

#import <UIKit/UIKit.h>


/**
 弹幕展现模式

 - fromTopToBottom: 自上而下
 - fromBottomToTop: 自下而上
 */
typedef NS_ENUM(NSUInteger, FJFLiveAnimationShowMode) {
    FJFLiveAnimationShowModeFromTopToBottom = 0,
    FJFLiveAnimationShowModeFromBottomToTop = 1,
};

/**
 弹幕消失模式
 - right: 向右移出
 - left: 向左移出
 */
typedef NS_ENUM(NSUInteger, FJFLiveAnimationHiddenMode) {
    FJFLiveAnimationHiddenModeNone = 0,
    FJFLiveAnimationHiddenModeLeft = 1,
    FJFLiveAnimationHiddenModeRight = 2,
    FJFLiveAnimationHiddenModeTop = 3,
    FJFLiveAnimationHiddenModeBottom = 4,
};

/**
 弹幕出现模式

 - none: 无效果
 - left: 从左到右出现（左进）
 */
typedef NS_ENUM(NSUInteger, FJFLiveAnimationAppearMode) {
    FJFLiveAnimationAppearModeNone = 0,
    FJFLiveAnimationAppearModeLeft = 1,
    FJFLiveAnimationAppearModeRight = 2,
};


/**
 弹幕添加模式（当弹幕达到最大数量后新增弹幕时）,默认替换

 - FJFLiveAnimationAddModeReplace: 当有新弹幕时会替换
 - FJFLiveAnimationAddModeAdd: 当有新弹幕时会进入队列
 */
typedef NS_ENUM(NSUInteger, FJFLiveAnimationAddMode) {
    FJFLiveAnimationAddModeReplace = 0,
    FJFLiveAnimationAddModeAdd     = 1,
};

#endif /* FJFLiveAnimationBase_h */
