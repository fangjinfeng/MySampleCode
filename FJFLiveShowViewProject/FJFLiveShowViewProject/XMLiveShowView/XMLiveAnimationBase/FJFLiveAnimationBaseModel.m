//
//  FJFLiveAnimationBaseModel.m
//  FJFLiveShowViewProject
//
//  Created by macmini on 8/20/20.
//  Copyright © 2020 LFC. All rights reserved.
//

#import "FJFLiveAnimationBaseModel.h"

@implementation FJFLiveAnimationBaseModel

- (NSString *)animationUniqueKey {
    if (!_animationUniqueKey.length) {
        _animationUniqueKey = [FJFLiveAnimationBaseModel uuid];
    }
    return _animationUniqueKey;
}

+ (NSString *)uuid{
    // create a new UUID which you own
    CFUUIDRef uuidref = CFUUIDCreate(kCFAllocatorDefault);
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    CFStringRef uuid = CFUUIDCreateString(kCFAllocatorDefault, uuidref);
    NSString *result = (__bridge NSString *)uuid;
    //release the uuidref
    CFRelease(uuidref);
    // release the UUID
    CFRelease(uuid);
    return result;
}
@end
