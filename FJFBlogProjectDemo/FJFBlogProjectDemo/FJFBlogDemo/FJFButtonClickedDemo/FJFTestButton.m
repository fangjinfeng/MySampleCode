//
//  FJFTestButton.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/5/12.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import "FJFTestButton.h"

@implementation FJFTestButton

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}
- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [super sendAction:action to:target forEvent:event];
}

- (void)testButtonClicked:(UIButton *)sender {
    NSLog(@"--------------------testButtonClicked");
}

- (void)testButtonClick:(UIButton *)sender {
    NSLog(@"--------------------testButtonClick");
}
@end
