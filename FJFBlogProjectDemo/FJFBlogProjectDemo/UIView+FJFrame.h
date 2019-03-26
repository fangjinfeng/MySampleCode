//
//  UIView+FJFrame.h
//  FJPhotoBrowserDemo
//
//  Created by fjf on 2017/7/28.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FJFrame)

/// 宽
@property (nonatomic,assign) CGFloat width;

/// 高
@property (nonatomic,assign) CGFloat height;

/// X坐标
@property (nonatomic,assign) CGFloat x;

/// Y坐标
@property (nonatomic,assign) CGFloat y;

/// 尺寸
@property (nonatomic,assign) CGSize size;

/// 坐标
@property (nonatomic,assign) CGPoint origin;

/// 在X轴的最大值
@property (assign,nonatomic,readonly) CGFloat maxX;

/// 在Y轴的最大值
@property (assign,nonatomic,readonly) CGFloat maxY;

/// 中心点的X坐标
@property (assign,nonatomic,readonly) CGFloat centerX;

/// 中心点的Y坐标
@property (assign,nonatomic,readonly) CGFloat centerY;

@end
