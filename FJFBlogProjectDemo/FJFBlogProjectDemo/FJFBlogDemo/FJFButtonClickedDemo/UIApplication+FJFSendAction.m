//
//  UIApplication+FJFSendAction.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/5/12.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import "NSObject+FJFSwizzle.h"
#import "UIApplication+FJFSendAction.h"

@implementation UIApplication (FJFSendAction)
#pragma mark - Public Methods
+ (void)load {
    //交换方法
    NSError *error = NULL;
    
    [UIApplication fjf_swizzleMethod:@selector(sendEvent:)
                          withMethod:@selector(fjf_sendEvent:)
                        error:&error];
    
    [UIApplication fjf_swizzleMethod:@selector(sendAction:to:from:forEvent:)
                          withMethod:@selector(fjf_sendAction:to:from:forEvent:)
                        error:&error];
}


#pragma mark - Private Methods

- (void)fjf_sendEvent:(UIEvent *)event {
    [self fjf_sendEvent:event];
}

- (BOOL)fjf_sendAction:(SEL)action to:(nullable id)target from:(nullable id)sender forEvent:(nullable UIEvent *)event {
    return [self fjf_sendAction:action to:target from:sender forEvent:event];
}
@end
