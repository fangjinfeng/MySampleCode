//
//  FJFCatonHandleViewController.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/6/25.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import "FJFCatonHandleTool.h"
#import "FJFCatonHandleViewController.h"

@interface FJFCatonHandleViewController ()
// 卡顿处理器
@property (nonatomic, strong) FJFCatonHandleTool *catonHandleTool;
@end

@implementation FJFCatonHandleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.catonHandleTool = [[FJFCatonHandleTool alloc] init];

    [self.catonHandleTool addTask:^{
        for (int i = 0; i < 5000; i++) {
            NSLog(@"-----------:%d", i);
        }
    }];

    [self.catonHandleTool addTask:^{
        for (int i = 0; i < 5000; i++) {
            NSLog(@"-----------:%d", i);
        }
    }];

    [self.catonHandleTool addTask:^{
        for (int i = 0; i < 5000; i++) {
            NSLog(@"-----------:%d", i);
        }
    }];

    [self.catonHandleTool addTask:^{
        for (int i = 0; i < 5000; i++) {
            NSLog(@"-----------:%d", i);
        }
    }];

    [self.catonHandleTool addTask:^{
        for (int i = 0; i < 5000; i++) {
            NSLog(@"-----------:%d", i);
        }
    }];
}
@end
