//
//  FJFMineTaskTipPopMenuView.h
//  FJFPopMenuViewDemo
//
//  Created by macmini on 24/10/2019.
//  Copyright © 2019 FJFPopMenuViewDemo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 任务 提醒 弹框
@interface FJFMineTaskTipPopMenuView : UIView
// contentLabel
@property (nonatomic, strong) UILabel *contentLabel;

/// 视图 宽度
/// @param contentString 内容文本
+ (CGFloat)viewWidthWithContentString:(NSString *)contentString;

/// 视图 高度
/// @param contentString 内容文本
+ (CGFloat)viewHeightWithContentString:(NSString *)contentString;

/// 显示 弹框
/// @param contentString 文本 内容
/// @param showPosition 显示 位置
+ (void)showTaskTipPopMenuViewWithContentString:(NSString *)contentString showPosition:(CGPoint)showPosition;
@end

NS_ASSUME_NONNULL_END
