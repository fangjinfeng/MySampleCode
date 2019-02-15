//
//  FJFImageControl.h
//  FJFButtonTestProject
//
//  Created by 方金峰 on 2019/2/11.
//  Copyright © 2019年 方金峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJFImageControl : UIControl
// tipLabel
@property (nonatomic, strong) UILabel *tipLabel;
// iconImageView
@property (nonatomic, strong) UIImageView *iconImageView;

/**
 初始化 FJFImageControl

 @param frame 位置
 @param title 标题
 @param iconImageName 图标
 @return 返回 FJFImageControl
 */
- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                iconImageName:(NSString *)iconImageName;
@end

NS_ASSUME_NONNULL_END
