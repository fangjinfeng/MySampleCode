

//
//  FJFLiveDefine.h
//  FJFLiveShowViewProject
//
//  Created by macmini on 9/3/20.
//  Copyright © 2020 macmini. All rights reserved.
//

#ifndef FJFLiveDefine_h
#define FJFLiveDefine_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import <Masonry/Masonry.h>

#define FJF_RGBColor(r, g, b)    FJF_RGBColorAlpha(r, g, b, 1.0)

#define FJF_RGBColorAlpha(r, g, b, a)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]


#define FJF_PingFangRegular_Font(value)  [UIFont fontWithName:@"PingFangSC-Regular" size:(value)]




/// 安全区顶部高度（状态栏高度）
static inline CGFloat SafeAreaTop() {
    if (@available(iOS 11.0, *)) {
        return UIApplication.sharedApplication.delegate.window.safeAreaInsets.top;
    }
    return 0;
}

/// 安全区底部高度
static inline CGFloat SafeAreaBottom() {
    if (@available(iOS 11.0, *)) {
        return UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom;
    }
    return 0;
}

/// 是否刘海屏
static inline BOOL IsIphoneX() {
    return SafeAreaBottom() > 0;
}

static inline CGFloat StatusBarHeight() {
    return (IsIphoneX() ? 44.f : 20.f);
}


/// 导航栏 高度
static inline CGFloat NavigationBarHeight() {
    return 44 + SafeAreaTop();
}

/// 安全区顶部高度（状态栏高度）
static inline CGFloat TabbarHeight() {
    return (IsIphoneX() ? 83 : 49);
}

#endif /* FJFLiveDefine_h */
