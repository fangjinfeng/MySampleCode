//
//  FJTabBarView+FJFBadge.h
//  FJTabbarViewControllerDemo
//
//  Created by 方金峰 on 2019/2/12.
//  Copyright © 2019年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (FJFBadge)
- (void)fjf_removeBadgeOnItemIndex:(NSInteger)index;

- (void)fjf_hideBadgeOnItemIndex:(NSInteger)index;

- (UIView *)fjf_showBadgeOnItemIndex:(NSInteger)index tabbarItemCount:(NSInteger)tabbarItemCount;
@end

NS_ASSUME_NONNULL_END
