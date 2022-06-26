//
//  FJFGreyHelper.h
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/4/7.
//  Copyright © 2022 方金峰. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJFGreyHelper : NSObject
// 单例
+ (instancetype)shared;
// 首页view
@property (nonatomic, strong) UIView *homeView;
// 首页VC类
@property (nonatomic, strong) NSString *homeVcClassName;
// 是否开启黑白色(总开关)
@property (nonatomic, assign) BOOL appGreyStyleEnable;
// 是否首页可见
@property (nonatomic, assign) BOOL isHomeVcVisible;
// 是否只有首页 显示黑白色(appGreyStyleEnable为ture，情况下起作用)
@property (nonatomic, assign) BOOL isOnlyHomeShowGreyStyle;
// 是否 即将跳转到首页外的其他页面
@property (nonatomic, assign) BOOL isWillJumpToOtherVcExceptHome;

// 灰度滤镜
+ (NSArray *)greyFilterArray;

+ (void)addGreyFilterToView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
