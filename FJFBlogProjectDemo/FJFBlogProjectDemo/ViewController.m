//
//  ViewController.m
//  FJFBlogProjectDemo
//
//  Created by 方金峰 on 2019/3/11.
//  Copyright © 2019年 方金峰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// boxImageView
@property (nonatomic, strong) UIImageView *boxImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *tmpContainerView = [[UIView alloc] initWithFrame:self.view.bounds];
    tmpContainerView.backgroundColor = [UIColor redColor];
    tmpContainerView.alpha = 0.4;
    [self.view addSubview:tmpContainerView];
    
    
    UIView *tmpSubView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    tmpSubView.backgroundColor = [UIColor greenColor];
    tmpSubView.alpha = 0.6;
    [tmpContainerView addSubview:tmpSubView];
    
}


@end
