//
//  FJFThreeViewController.m
//  FJFTouchEventDemo
//
//  Created by 方金峰 on 2019/2/13.
//  Copyright © 2019年 方金峰. All rights reserved.
//

#import "FJFSwitch.h"
#import "FJFTapView.h"
#import "FJFButton.h"
#import "FJFLongPressView.h"
#import "FJFImageControl.h"
#import "FJFTapGestureRecognizer.h"
#import "FJFThreeViewController.h"
#import "FJFLongPressGestureRecognizer.h"

@interface FJFThreeViewController ()

@end

@implementation FJFThreeViewController

#pragma mark -------------------------- Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"分类";
    
    // view tap
    FJFTapView *tmpContainerView = [[FJFTapView alloc] initWithFrame:CGRectMake(50, 80, 260, 300)];
    tmpContainerView.backgroundColor = [UIColor redColor];
    FJFTapGestureRecognizer *tapGesture = [[FJFTapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    [tmpContainerView addGestureRecognizer:tapGesture];
    
    [self.view addSubview:tmpContainerView];
    
    // view longPress
    FJFLongPressView *tmpLongPressView = [[FJFLongPressView alloc] initWithFrame:CGRectMake(50, 400, 260, 200)];
    tmpLongPressView.backgroundColor = [UIColor grayColor];
    FJFLongPressGestureRecognizer *longPressGesture = [[FJFLongPressGestureRecognizer alloc] initWithTarget:self action:@selector(viewlongPress:)];
    [tmpLongPressView addGestureRecognizer:longPressGesture];
    [self.view addSubview:tmpLongPressView];
    
    // button
    FJFButton *tmpButton = [[FJFButton alloc] initWithFrame:CGRectMake(100, 50, 120, 80)];
    tmpButton.backgroundColor = [UIColor greenColor];
    [tmpButton setTitle:@"UIButton" forState:UIControlStateNormal];
    [tmpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tmpButton addTarget:self action:@selector(tmpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [tmpContainerView addSubview:tmpButton];
    
  
    
    // imageControl
    FJFImageControl *imageControl = [[FJFImageControl alloc] initWithFrame:CGRectMake(100, 150, 120, 80) title:@"imageControl" iconImageName:@"ic_red_box.png"];
    imageControl.backgroundColor = [UIColor blueColor];
    [imageControl addTarget:self action:@selector(imageControlTouch:) forControlEvents:UIControlEventTouchUpInside];
    [tmpContainerView addSubview:imageControl];
    
    
    // UISwitch
    FJFSwitch *tmpSwitch = [[FJFSwitch alloc] initWithFrame:CGRectMake(100, 250, 30, 30)];
    tmpSwitch.on = YES;
    [tmpSwitch addTarget:self action:@selector(tmpSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    [tmpContainerView addSubview:tmpSwitch];
    
}

#pragma mark -------------------------- Response Event

// tap
- (void)viewTap:(UITapGestureRecognizer *)tap {
    NSLog(@"%s", __FUNCTION__);
}

// longPress
- (void)viewlongPress:(UILongPressGestureRecognizer *)longPress {
    NSLog(@"%s", __FUNCTION__);
}

- (void)tmpSwitchChanged:(UISwitch *)sender {
      NSLog(@"%s", __FUNCTION__);
}
// buttonClicked
- (void)tmpButtonClicked:(UIButton *)sender {
    NSLog(@"%s", __FUNCTION__);
}

// controlTouch
- (void)imageControlTouch:(FJFImageControl *)imageControl {
     NSLog(@"%s", __FUNCTION__);
}


@end
