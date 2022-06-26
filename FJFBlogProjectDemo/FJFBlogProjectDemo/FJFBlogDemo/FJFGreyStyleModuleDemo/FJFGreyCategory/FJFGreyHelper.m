//
//  FJFGreyHelper.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/4/7.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import "FJFGreyHelper.h"
#import "UIColor+FJFGreyColor.h"
#import "UIImageView+FJFGreyImageview.h"

static NSInteger kFJFGreyFilterTag = 10001;

@implementation FJFGreyHelper

+ (instancetype)shared {
    static FJFGreyHelper *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
    });
    return sharedManager;
}

+ (void)addGreyFilterToView:(UIView *)view {
    UIView *coverView = [[UIView alloc] initWithFrame:view.bounds];
    coverView.userInteractionEnabled = NO;
    coverView.tag = kFJFGreyFilterTag;
    coverView.backgroundColor = [UIColor colorWithRed:0 green:200/255.0 blue:0 alpha:1.0];
    coverView.layer.compositingFilter = @"saturationBlendMode";
    coverView.layer.zPosition = FLT_MAX;
    [view addSubview:coverView];
}

+ (void)removeGreyFilterToView:(UIView *)view {
    UIView *greyView = [view viewWithTag:kFJFGreyFilterTag];
    [greyView removeFromSuperview];
}

// 灰度滤镜
+ (NSArray *)greyFilterArray {
    //获取RGBA颜色数值
    CGFloat r,g,b,a;
    [[UIColor greenColor] getRed:&r green:&g blue:&b alpha:&a];
    //创建滤镜
    id cls = NSClassFromString(@"CAFilter");
    id filter = [cls filterWithName:@"colorMonochrome"];
    //设置滤镜参数
    [filter setValue:@[@(r),@(g),@(b),@(a)] forKey:@"inputColor"];
    [filter setValue:@(0) forKey:@"inputBias"];
    [filter setValue:@(1) forKey:@"inputAmount"];
    return [NSArray arrayWithObject:filter];
}

// 是否是首页子视图
- (BOOL)isHomeVcSubViewWithView:(UIView *)view {
    return [FJFGreyHelper.shared.homeView isDescendantOfView:view];
}

// 判断是否为首页vc
- (BOOL)judgeIsHomeOwnVcWithVc:(UIViewController *)vc {
    if ([NSStringFromClass(vc.class) isEqualToString:FJFGreyHelper.shared.homeVcClassName]) {
        return true;
    }
    return false;
}

// 遍历父视图的所有子视图，包括嵌套的子视图
- (void)traverseHandleAllSubviews:(UIView *)view {
    [self handleViewToGreyStyleView:view];
    for (UIView *subView in view.subviews) {
        if (subView.subviews.count) {
           [self traverseHandleAllSubviews:subView];
        } else {
            [self handleViewToGreyStyleView:subView];
        }
    }
}

// 将子视图处理为灰色
- (void)handleViewToGreyStyleView:(UIView *)view {
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *tmpLabel = (UILabel *)view;
        tmpLabel.attributedText = [UIColor fjf_getGreyAttributedTextWithTextColor:tmpLabel.textColor attributeText:tmpLabel.attributedText];
    }
    else if([view isKindOfClass:[UIImageView class]]) {
        UIImageView *tmpImageView = (UIImageView *)view;
        [tmpImageView fjf_convertToGrayImageWithImage:tmpImageView.image];
    }
    view.backgroundColor = [UIColor fjf_generateGrayColorWithOriginalColor:view.backgroundColor];
}
@end
