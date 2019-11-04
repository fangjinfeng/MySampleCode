//
//  FJFMineTaskIntroducePopMenuView.h
//  FJFPopMenuViewDemo
//
//  Created by macmini on 24/10/2019.
//  Copyright © 2019 FJFPopMenuViewDemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJFPopMenuViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface FJFMineTaskIntroducePopMenuView : UIView
// titleLabel
@property (nonatomic, strong) UILabel  *titleLabel;
// contentLabel
@property (nonatomic, strong) UILabel  *contentLabel;
// closeButton
@property (nonatomic, strong) UIButton *closeButton;
// closeButtonClickedBlock
@property (nonatomic, copy) FJFButtonClickBlock closeButtonClickedBlock;

/// 视图 宽度
+ (CGFloat)viewWidth;
/// 获取 cell 高度
/// @param contentString 文本内容
+ (CGFloat)viewHeightWithContentString:(NSString *)contentString;

/// 显示 介绍 弹框
/// @param titleString 标题
/// @param contentString 内容
/// @param showPosition 显示 位置
+ (void)showTaskTipPopMenuViewWithTitleString:(NSString *)titleString
                                contentString:(NSString *)contentString
                                 showPosition:(CGPoint)showPosition;
@end

NS_ASSUME_NONNULL_END
