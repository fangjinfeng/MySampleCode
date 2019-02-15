//
//  FJFCustomPopMenuTriangleView.h
//  FJFPopMenu
//
//  Created by 方金峰 on 2018/12/21.
//  Copyright © 2018年 方金峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJFCustomPopMenuIndicateView : UIView
// fillColor
@property (nonatomic, strong) UIColor *fillColor;
// 是否 正立 三角形
@property (nonatomic, assign) BOOL isHeadstandIndicateView;
// 更新 控件
- (void)updateViewControls;
@end

NS_ASSUME_NONNULL_END
