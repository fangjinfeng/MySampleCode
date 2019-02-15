//
//  ViewController.m
//  FJFZombieSniffer
//
//  Created by fjf on 2018/7/30.
//  Copyright © 2018年 fjf. All rights reserved.
//

#import "ViewController.h"

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark -------------------------- Life  Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *tmpBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
    [tmpBtn addTarget:self action:@selector(tmpBtnClickd:) forControlEvents:UIControlEventTouchUpInside];
    tmpBtn.backgroundColor = [UIColor redColor];
    [tmpBtn setTitle:@"Button" forState:UIControlStateNormal];
    [self.view addSubview:tmpBtn];
}


#pragma mark -------------------------- Response  Event

- (void)tmpBtnClickd:(UIButton *)sender {
    UIView* testObj = [[UIView alloc] init];
    [testObj release];
    for (int i = 0; i < 10; i++) {
        UIView* testView = [[UIView alloc] initWithFrame:CGRectMake(0,200,CGRectGetWidth(self.view.bounds), 60)];
        [self.view addSubview:testView];
    }
    [testObj setNeedsLayout];
}

@end

