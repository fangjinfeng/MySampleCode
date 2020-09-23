//
//  FJFLiveMarqueeBaseModel.m
//  FJFLiveShowViewProject
//
//  Created by macmini on 9/16/20.
//  Copyright © 2020 macmini. All rights reserved.
//

#import "FJFLiveMarqueeBaseModel.h"

@implementation FJFLiveMarqueeBaseModel
- (NSString *)animationUniqueKey {
    if (!_animationUniqueKey.length) {
        _animationUniqueKey = [FJFLiveMarqueeBaseModel uuid];
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
