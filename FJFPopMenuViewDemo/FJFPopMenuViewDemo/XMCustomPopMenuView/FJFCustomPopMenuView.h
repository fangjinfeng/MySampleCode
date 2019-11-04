//
//  FJCustomDialogView.h
//  FJFPopMenuViewDemo
//
//  Created by macmini on 2018/3/8.
//  Copyright © 2018年 FJFPopMenuViewDemo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HLLCustomPopMenuButtonClickBlock)(UIButton *button, id value);

@class FJFCustomPopMenuStytle;

@interface FJFCustomPopMenuView : UIView
// 配置 参数
@property (nonatomic, strong) FJFCustomPopMenuStytle *customDialogStyle;
// backButtonClickedBlock
@property (nonatomic, copy) HLLCustomPopMenuButtonClickBlock backButtonClickedBlock;

@property (nonatomic, assign) CGFloat containerContentViewHeight;

- (instancetype)initWithContentViewHeight:(CGFloat)contentViewHeight;

// 消失
- (void)dimissView;
// 容器 内容 视图 viewBounds
- (CGRect)containerContentViewBounds;
// 添加 子视图 到 容器 view
- (void)addSubViewToContainerContentView:(UIView *)subView;
// 显示
- (void)showFromParentView:(UIView *)parentView position:(CGPoint)position;
@end
