//
//  FJFLiveAnimationBaseView.m
//  FJFLiveShowViewProject
//
//  Created by macmini on 8/20/20.
//  Copyright © 2020 LFC. All rights reserved.
//

#import "FJFLiveAnimationBaseView.h"

@interface FJFLiveAnimationBaseView()
// 定时器控制自身移除
@property (nonatomic ,strong) NSTimer * liveTimer;
// 定时 时间
@property (nonatomic ,assign) NSInteger liveTimerForSecond;
@end

@implementation FJFLiveAnimationBaseView
#pragma mark - Life Circle
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.kTimeOut = 2;
        self.liveTimerForSecond = 0;
        self.kRemoveAnimationTime = 0.5;
        self.kNumberAnimationTime = 0.5;
    }
    return self;
}

#pragma mark - Public Methods
- (void)updateControlsWithLiveModel:(FJFLiveAnimationBaseModel *)liveModel {
    _liveModel = liveModel;
    [self startTimer];
}

- (void)resetTimer {
    self.liveTimerForSecond = 0;
}

- (void)startTimer{
    [self stopTimer];
   _liveTimer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleLiveTimerCount) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_liveTimer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    if (_liveTimer) {
        [_liveTimer invalidate];
        _liveTimer = nil;
    }
}

- (void)dimssView {
    self.isLeavingAnimation = YES;
    CGFloat xChanged = 0;
    CGFloat yChanged = 0;
    switch (self.hiddenModel) {
        case FJFLiveAnimationHiddenModeNone:
            xChanged = 0;
            yChanged = 0;
            break;
        case FJFLiveAnimationHiddenModeLeft:
            xChanged = -[UIScreen mainScreen].bounds.size.width;
            break;
        case FJFLiveAnimationHiddenModeRight:
            xChanged = [UIScreen mainScreen].bounds.size.width;
            break;
        case FJFLiveAnimationHiddenModeTop:
            yChanged = -[UIScreen mainScreen].bounds.size.height;
            break;
        case FJFLiveAnimationHiddenModeBottom:
            yChanged = [UIScreen mainScreen].bounds.size.height;;
            break;
        default:
            break;
    }
    if (self.hiddenModel == FJFLiveAnimationHiddenModeNone) {
        self.isLeavingAnimation = NO;
        if (self.animationViewShowTimeOut) {
            self.animationViewShowTimeOut(self);
        }
        [self removeFromSuperview];
    } else {
        [UIView animateWithDuration:self.kRemoveAnimationTime delay:self.kNumberAnimationTime options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.transform = CGAffineTransformTranslate(self.transform, xChanged, yChanged);
        } completion:^(BOOL finished) {
            if (finished) {
                self.isLeavingAnimation = NO;
                if (self.animationViewShowTimeOut) {
                    self.animationViewShowTimeOut(self);
                }
                [self removeFromSuperview];
            }
        }];
    }
    [self stopTimer];
}
#pragma mark - Private Methods

- (void)handleLiveTimerCount{
    self.liveTimerForSecond += 1;
    if (self.liveTimerForSecond > self.kTimeOut) {
        [self dimssView];
    }
}

@end
