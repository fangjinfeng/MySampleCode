//
//  ViewController.m
//  FJFTouchEventDemo
//
//  Created by 方金峰 on 2019/2/13.
//  Copyright © 2019年 方金峰. All rights reserved.
//

// view
#import "AView.h"
#import "BView.h"
#import "CView.h"
#import "DView.h"
#import "EView.h"
#import "FView.h"
// vc
#import "FJFFirstViewController.h"

@interface FJFFirstViewController ()

@end

@implementation FJFFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // title
    self.title = @"事件传递";
    // AView
    AView *tmpAview = [[AView alloc] initWithFrame:CGRectMake(20, 80, 300, 400)];
    tmpAview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tmpAview];
    
    // BView
    BView *tmpBview = [[BView alloc] initWithFrame:CGRectMake(50, 10, 200, 150)];
    tmpBview.backgroundColor = [UIColor yellowColor];
    [tmpAview addSubview:tmpBview];
    
    // CView
    CView *tmpCview = [[CView alloc] initWithFrame:CGRectMake(90, 130, 180, 200)];
    tmpCview.backgroundColor = [UIColor blueColor];
    [tmpAview addSubview:tmpCview];

    
    // DView
    DView *tmpDview = [[DView alloc] initWithFrame:CGRectMake(40, 20, 120, 80)];
    tmpDview.backgroundColor = [UIColor lightGrayColor];
    [tmpBview addSubview:tmpDview];
    
    // EView
    EView *tmpEview = [[EView alloc] initWithFrame:CGRectMake(50, 20, 80, 50)];
    tmpEview.backgroundColor = [UIColor greenColor];
    [tmpCview addSubview:tmpEview];
    
    // FView
    FView *tmpFview = [[FView alloc] initWithFrame:CGRectMake(50, 100, 80, 50)];
    tmpFview.backgroundColor = [UIColor orangeColor];
    [tmpCview addSubview:tmpFview];
}


@end
