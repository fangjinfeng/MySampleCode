
//
//  FJFSystemMuteHelper.m
//  FJFSystemMuteDemo
//
//  Created by fjf on 05/09/2019.
//  Copyright © 2019 fjf. All rights reserved.
//

#import "FJFSystemMuteHelper.h"
#import <objc/runtime.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


static FJFSystemMuteHelperMuteSwitchBlock _muteSwitchBlock;

static double _kFJFSystemMuteHelperStartTime = 0.0f;

@implementation FJFSystemMuteHelper

#pragma mark -------------------------- Public Methods


/// 是否系统音量 静音
+ (BOOL)isSystmeVolumeMute {
    NSLog(@"volume = %f", [self systemVolume]);
    return ([self systemVolume] < 0.001) ? YES : NO;
}

/// 系统 音量
+ (float)systemVolume {
    CGFloat volume = [self volumeViewSlider].value;
    if (volume == 0) {
        volume = [[AVAudioSession sharedInstance] outputVolume];
    }
    return volume;
}

/// 检测 静音按键 和 系统音量 两者是否 有一个 静音
+ (void)detectAllSystemMuteWithMuteSwitchBlock:(FJFSystemMuteHelperMuteSwitchBlock)muteSwitchBlock {
    BOOL isMute = [self isSystmeVolumeMute];
    if (isMute) {
        if (muteSwitchBlock) {
            muteSwitchBlock(isMute);
        }
        return;
    }
    [self detectSystemMuteStatusWithMuteSwitchBlock:muteSwitchBlock];
}

/// 检测 静音 按键 状态
+ (void)detectSystemMuteStatusWithMuteSwitchBlock:(FJFSystemMuteHelperMuteSwitchBlock)muteSwitchBlock {
    _muteSwitchBlock = [muteSwitchBlock copy];
    _kFJFSystemMuteHelperStartTime = [[NSDate date] timeIntervalSince1970];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"detection" ofType:@"aiff"];
    NSURL *fileUrl = [NSURL URLWithString:filePath];
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    AudioServicesAddSystemSoundCompletion(soundID,NULL,NULL,soundCompleteCallBack,NULL);
    AudioServicesPlaySystemSound(soundID);
}


#pragma mark -------------------------- Private Methods

void soundCompleteCallBack(SystemSoundID soundID, void *clientData) {
   AudioServicesRemoveSystemSoundCompletion (soundID);
    BOOL isMute = NO;
    double endTime = [[NSDate date] timeIntervalSince1970];
    double diffTime = endTime - _kFJFSystemMuteHelperStartTime;
    if (diffTime < 0.01) {
        isMute = YES;
    }
    
    if (_muteSwitchBlock) {
        _muteSwitchBlock(isMute);
    }
}


#pragma mark - 系统 音量
/// 系统 音量 指示器
+ (UISlider *)getSystemVolumeViewSlider {
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    UISlider *volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            volumeViewSlider = (UISlider *)view;
            [self setVolumeViewSlider:volumeViewSlider];
            break;
        }
    }
    return volumeViewSlider;
}

+ (void)setVolumeViewSlider:(UISlider *)volumeViewSlider {
    objc_setAssociatedObject(self, @selector(volumeViewSlider), volumeViewSlider, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (UISlider *)volumeViewSlider {
    UISlider *tmpSlider =  objc_getAssociatedObject(self, @selector(volumeViewSlider));
    if (!tmpSlider) {
        tmpSlider = [self getSystemVolumeViewSlider];
    }
    return tmpSlider;
}

@end
