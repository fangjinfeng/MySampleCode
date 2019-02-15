//
//  FJCustomDialogView.h
//  QNIntelligentRobot
//
//  Created by fjf on 2018/3/8.
//  Copyright © 2018年 QNIntelligentRobot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJFButtonClickedBlock.h"

@class FJFCustomPopMenuStytle;

@interface FJFCustomPopMenuView : UIView
// backButtonClickedBlock
@property (nonatomic, copy) FJFButtonClickBlock backButtonClickedBlock;
// 配置 参数
@property (nonatomic, strong) FJFCustomPopMenuStytle *customDialogStyle;

// 消失
- (void)dimissView;
// 容器 内容 视图 viewBounds
- (CGRect)containerContentViewBounds;
// 添加 子视图 到 容器 view
- (void)addSubViewToContainerContentView:(UIView *)subView;
// 显示
- (void)showFromParentView:(UIView *)parentView position:(CGPoint)position;
@end
