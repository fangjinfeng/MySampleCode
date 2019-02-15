
//
//  FJCustomDialogStytle.m
//  QNIntelligentRobot
//
//  Created by fjf on 2018/3/8.
//  Copyright © 2018年 QNIntelligentRobot. All rights reserved.
//

#import "FJFButtonClickedBlock.h"
#import "FJFCustomPopMenuStytle.h"

@implementation FJFCustomPopMenuStytle
#pragma mark --------------- Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _animateDuration = 0.3f;
        _indicateViewWidth = 12.0f;
        _indicateViewHeight = 8.0f;
        _indicateViewTopSpacing = 0.0f;
        _containerViewLeftSpacing = 16.0f;
        _containerViewRightSpacing = 16.0f;
        _animateShowType = FJFCustomMenuAnimateTypeFromTop;
        _animateHideType = FJFCustomMenuAnimateTypeFromTop;
        _containerContentViewHeight = 220.0f;
        _containerViewHeight = _containerContentViewHeight + _indicateViewHeight + _indicateViewTopSpacing;
        _menuViewBackgroundColor = kFJFColorValueAlpha(0x000000, 0.54);
        _enableOfBackgroundButton = YES;
        _indicateViewColor = [UIColor whiteColor];
        _containerViewBackgroundColor = [UIColor clearColor];
        _containerContentViewBackgroundColor = [UIColor whiteColor];
      
    }
    return self;
}
@end
