//
//  FJFGreyStyleModuleVC.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2021/12/17.
//  Copyright © 2021 方金峰. All rights reserved.
//

#import "Masonry.h"
#import "SDWebImage.h"
#import "FJFGreyStyleModuleVC.h"

@interface FJFGreyStyleModuleVC ()
// imageView
@property (nonatomic, strong) UIImageView *imageView;

// animateImageView
@property (nonatomic, strong) SDAnimatedImageView *animateImageView;
@end

@implementation FJFGreyStyleModuleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改灰色样式";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];

}

@end
