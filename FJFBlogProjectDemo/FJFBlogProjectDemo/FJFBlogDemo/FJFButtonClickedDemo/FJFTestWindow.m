//
//  FJFTestWindow.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/5/13.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import "FJFTestWindow.h"

@implementation FJFTestWindow

- (void)testButtonClicked:(UIButton *)sender {
    NSLog(@"--------------------");
}

- (void)sendEvent:(UIEvent *)event {
    [super sendEvent:event];
}
    
@end
