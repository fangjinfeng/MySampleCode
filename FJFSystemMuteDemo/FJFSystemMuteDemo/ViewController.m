//
//  ViewController.m
//  FJFSystemMuteDemo
//
//  Created by fjf on 05/09/2019.
//  Copyright © 2019 fjf. All rights reserved.
//

#import "ViewController.h"
#import "FJFSystemMuteHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [FJFSystemMuteHelper detectAllSystemMuteWithMuteSwitchBlock:^(BOOL isMute) {
        NSLog(@"isMute : %d", isMute);
    }];
}

@end
