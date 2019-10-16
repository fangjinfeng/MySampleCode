//
//  ViewController.m
//  FJFViewBorderDemoo
//
//  Created by macmini on 16/10/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "ViewController.h"
#import "UIView+FJFCornerBorder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 顶部 圆角 边框
    UIView *tmpTopView = [[UIView alloc] initWithFrame:CGRectMake(30, 100, 150, 150)];
    [tmpTopView fjf_setCornerRadius:10 borderWidth:1.0f borderColor:[UIColor blackColor] viewBorderType:FJFViewBorderTypeTop];
    [self.view addSubview:tmpTopView];
    
    
    UIView *tmpBottomView = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 150, 150)];
    [tmpBottomView fjf_setCornerRadius:10 borderWidth:1.0f borderColor:[UIColor blackColor] viewBorderType:FJFViewBorderTypeBottom];
    [self.view addSubview:tmpBottomView];
    
    
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(130, 280, 150, 150)];
     [tmpView fjf_setCornerRadius:10 borderWidth:1.0f borderColor:[UIColor blackColor] viewBorderType:FJFViewBorderTypeAll];
     [self.view addSubview:tmpView];
}


@end
