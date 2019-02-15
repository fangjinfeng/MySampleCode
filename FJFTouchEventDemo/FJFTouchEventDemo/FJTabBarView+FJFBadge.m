
//
//  UITabBar+FJFBadge.m
//  FJTabbarViewControllerDemo
//
//  Created by 方金峰 on 2019/2/12.
//  Copyright © 2019年 fjf. All rights reserved.
//

#import "FJFButtonClickedBlock.h"
#import "FJFCustomPopMenuIndicateView.h"
#import "FJTabBarView+FJFBadge.h"
// 小红点提示 tag
static const NSInteger kFJFTabBarControllerTabbarItemTipCircleViewTag = 9990;

@implementation UITabBar (FJFBadge)

- (UIView *)fjf_showBadgeOnItemIndex:(NSInteger)index tabbarItemCount:(NSInteger)tabbarItemCount {
    
    //移除之前的小红点
    [self fjf_removeBadgeOnItemIndex:index];
    
    NSString *tmpText = @"有新任务";
    
    CGRect tabFrame = self.frame;
    //确定小红点的位置
    NSDictionary* attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGFloat containerViewWidth = [tmpText boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size.width + 10.0f;
    CGFloat containerViewHeight = 28.0f;
    CGFloat tabbarItemWidth = tabFrame.size.width / tabbarItemCount;
    CGFloat percentX = index * tabbarItemWidth;
    CGFloat containerViewX = percentX + ((tabbarItemWidth - containerViewWidth) / 2.0);
    CGFloat containerViewY =  - containerViewHeight;
    
    
    // 容器 视图
    UIView *containerView = [[UIView alloc]init];
    containerView.tag = kFJFTabBarControllerTabbarItemTipCircleViewTag + index;
    containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewWidth, containerViewHeight);
    
    // label 容器
    CGFloat labelContainerViewHeight = containerViewHeight - 6.0f;
    UIView *labelContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerViewWidth, labelContainerViewHeight)];
    labelContainerView.layer.cornerRadius = 2.0f;
    labelContainerView.backgroundColor =  kFJFColorValueAlpha(0x424456, 0.87f);
    [containerView addSubview:labelContainerView];
    
    
    // 提示label
    UILabel *tmpLabel = [[UILabel alloc] initWithFrame:labelContainerView.bounds];
    tmpLabel.font = [UIFont systemFontOfSize:12.0];
    tmpLabel.textColor = kFJFColorValueAlpha(0xFFFFFF, 1.0f);
    tmpLabel.text = tmpText;
    tmpLabel.textAlignment = NSTextAlignmentCenter;
    [labelContainerView addSubview:tmpLabel];
    
    
    // 箭头
    CGFloat indicateViewWidth = 10.0f;
    CGFloat indicateViewHeight = 6.0f;
    CGFloat indicateViewX = (containerViewWidth - indicateViewWidth) / 2.0f;
    CGFloat indicateViewY = CGRectGetMaxY(tmpLabel.frame);
    FJFCustomPopMenuIndicateView *indicateView = [[FJFCustomPopMenuIndicateView alloc] initWithFrame:CGRectMake(indicateViewX, indicateViewY, indicateViewWidth, indicateViewHeight)];
    indicateView.fillColor = kFJFColorValueAlpha(0x424456, 0.87f);
    indicateView.isHeadstandIndicateView = YES;
    [indicateView updateViewControls];
    [containerView addSubview:indicateView];
    [self addSubview:containerView];
    
    return containerView;
}

- (void)fjf_hideBadgeOnItemIndex:(NSInteger)index{
    
    //移除小红点
    [self fjf_removeBadgeOnItemIndex:index];
    
}

- (void)fjf_removeBadgeOnItemIndex:(NSInteger)index{
    
    UIView *circleView = [self viewWithTag:(kFJFTabBarControllerTabbarItemTipCircleViewTag+index)];
    if (circleView) {
        [circleView removeFromSuperview];
    }
}

@end
