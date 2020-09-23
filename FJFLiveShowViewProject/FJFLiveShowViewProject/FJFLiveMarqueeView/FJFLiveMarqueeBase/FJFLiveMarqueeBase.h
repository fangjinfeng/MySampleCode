//
//  FJFLiveMarqueeBase.h
//  FJFLiveShowViewProject
//
//  Created by macmini on 9/16/20.
//  Copyright © 2020 macmini. All rights reserved.
//

#ifndef FJFLiveMarqueeBase_h
#define FJFLiveMarqueeBase_h

#import <UIKit/UIKit.h>

/**
 弹幕出现模式
 - none: 无效果
 - left: 从左到右出现（左进）
 - right: 从右到右出现（左进）
 */
typedef NS_ENUM(NSUInteger, FJFLiveMarqueeAppearMode) {
    FJFLiveMarqueeAppearModeNone = 0,
    FJFLiveMarqueeAppearModeLeft = 1,
    FJFLiveMarqueeAppearModeRight = 2,
};

// 新加的跑马灯的y坐标的类型
typedef NS_ENUM(NSInteger, FJFLiveMarqueePositionType) {
    FJFLiveMarqueePositionTypeFix, // 固定位置
    FJFLiveMarqueePositionTypeRandomTracks = 0, //将OCBarrageRenderView分成几条轨道, 随机选一条展示
    FJFLiveMarqueePositionTypeRandom, // y坐标随机
    FJFLiveMarqueePositionTypeIncrease, //y坐标递增, 循环
};

#endif /* FJFLiveMarqueeBase_h */
