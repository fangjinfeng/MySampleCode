
//
//  FJFTableViewController.m
//  FJFTouchEventDemo
//
//  Created by 方金峰 on 2019/2/13.
//  Copyright © 2019年 方金峰. All rights reserved.
//

#import "FJFTabbar.h"
#import "FJTabBarView+FJFBadge.h"
#import "FJFFirstViewController.h"
#import "FJFSecondViewController.h"
#import "FJFThreeViewController.h"
#import "FJFFourViewController.h"
#import "FJFButtonClickedBlock.h"
#import "FJFTabBarViewController.h"

@implementation FJFTabBarViewController

#pragma mark -------------------------- Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViewControls];
    [self defaultTabBar];
}

#pragma mark -------------------------- Private Methods

- (void)setupViewControls {
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    FJFTabbar *tabbar = [[FJFTabbar alloc] init];
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    // vc
    FJFFirstViewController *tmpVc = [[FJFFirstViewController alloc] init];
    FJFSecondViewController *tmpSecondVc = [[FJFSecondViewController alloc] init];
    FJFThreeViewController *tmpThreeVc = [[FJFThreeViewController alloc] init];
    FJFFourViewController *tmpFourVc = [[FJFFourViewController alloc] init];
    
    // nav
    UINavigationController *tmpfirstNav = [[UINavigationController alloc] initWithRootViewController:tmpVc];
    UINavigationController *tmpSecondNav = [[UINavigationController alloc] initWithRootViewController:tmpSecondVc];
    UINavigationController *tmpThreeNav = [[UINavigationController alloc] initWithRootViewController:tmpThreeVc];
    UINavigationController *tmpFourNav = [[UINavigationController alloc] initWithRootViewController:tmpFourVc];
    
     self.viewControllers = @[tmpfirstNav, tmpSecondNav, tmpThreeNav, tmpFourNav];
}
- (void)defaultTabBar {
    
   

    self.tabBar.backgroundColor = kFJFColorValueAlpha(0xf3f4f5, 1.0f);

    NSArray* titles = @[@"首页",@"精选",@"分类",@"我的"];
    NSArray *imageNameArray = [NSArray arrayWithObjects:
                               @"tab_jingxuan_hui.png",
                               @"tab_faxian_hui.png",
                               @"tab_dianpu_hui.png",
                               @"tab_wode_hui.png",
                               nil];
    
    NSArray *selectedImageNameArray = [NSArray arrayWithObjects:
                                       @"tab_jingxuan_xuanzhong.png",
                                       @"tab_faxian_xuanzhong.png",
                                       @"tab_dianpu_xuanzhong.png",
                                       @"tab_wode_xuanzhong.png",
                                       nil];

    for (UITabBarItem* item in self.tabBar.items){
        NSInteger index = [self.tabBar.items indexOfObject:item];

        [item setTitle:titles[index]];
        [item setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f],NSForegroundColorAttributeName:kFJFColorValueAlpha(0x000000, 0.54f)} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f],NSForegroundColorAttributeName:kFJFColorValueAlpha(0xFF0000, 0.88)} forState:UIControlStateSelected];
        
        UIImage *normalImage = [UIImage imageNamed:imageNameArray[index]];
        UIImage *selectedImage = [UIImage imageNamed:selectedImageNameArray[index]];
        [item setImage:normalImage];
        [item setSelectedImage:selectedImage];
        if (index == 2) {
            UIView *indicateView =  [self.tabBar fjf_showBadgeOnItemIndex:2 tabbarItemCount:4];
            ((FJFTabbar *)self.tabBar).indicateView = indicateView;
            indicateView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(indicateViewTap:)];
            [indicateView addGestureRecognizer:tapGesture];
        }
    }
}


#pragma mark -------------------------- Response Event
// tap 事件
- (void)indicateViewTap:(UITapGestureRecognizer *)tapGesture {
    self.selectedIndex = 2;
    [self.tabBar fjf_hideBadgeOnItemIndex:2];
}
@end
