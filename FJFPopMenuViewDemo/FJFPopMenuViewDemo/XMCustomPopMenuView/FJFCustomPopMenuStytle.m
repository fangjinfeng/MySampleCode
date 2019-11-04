
//
//  FJCustomDialogStytle.m
//  FJFPopMenuViewDemo
//
//  Created by macmini on 2018/3/8.
//  Copyright © 2018年 FJFPopMenuViewDemo. All rights reserved.
//

#import "FJFCustomPopMenuStytle.h"

@implementation FJFCustomPopMenuStytle
#pragma mark --------------- Life Circle
- (instancetype)initWithContainerViewHeight:(CGFloat)containerViewHeight {
    _containerContentViewHeight = containerViewHeight;
    return [self init];
}


- (instancetype)init {
    if(self = [super init]) {
        _animateDuration = 0.3f;
        _indicateViewWidth = 12.0f;
        _indicateViewHeight = 8.0f;
        _indicateViewTopSpacing = 0.0f;
        _containerViewLeftSpacing = 16.0f;
        _containerViewRightSpacing = 16.0f;
        _animateShowType = FJFCustomMenuAnimateTypeFromTop;
        _animateHideType = FJFCustomMenuAnimateTypeFromTop;
        _positionType = FJFCustomMenuIndicateViewPositionTypeBottom;
        _indicateViewOffsetX = 20.0f;
        _containerContentViewCornerRadius = 4.0f;
        _containerContentViewBorderColor = [UIColor clearColor];
        _containerContentViewBorderWidth = 0;
        _containerViewHeight = _containerContentViewHeight + _indicateViewHeight + _indicateViewTopSpacing;
        _menuViewBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _enableOfBackgroundButton = YES;
        _indicateViewColor = [UIColor whiteColor];
        _containerViewBackgroundColor = [UIColor clearColor];
        _containerContentViewBackgroundColor = [UIColor whiteColor];
    }
    return self;
}
@end
