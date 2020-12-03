
//
//  FJFExpandLabelViewController.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 04/02/2020.
//  Copyright © 2020 macmini. All rights reserved.
//


#import "FJFExpandLabel.h"
#import <CoreText/CoreText.h>
#import "FJFExpandLabelViewController.h"

@interface FJFExpandLabelViewController ()

@end

@implementation FJFExpandLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    dispatch_queue_t queue = dispatch_queue_create(@"111111111111", nil);
    dispatch_queue_t secondQueue = dispatch_queue_create(@"111111111111", nil);
    
    FJFExpandLabelStyle *tmpLabelStyle = [[FJFExpandLabelStyle alloc] init];
    tmpLabelStyle.limitWidth = 200;
    tmpLabelStyle.contentLabelStyle.labelText = @"风刀霜剑法拉第是积分拉的屎减肥啦的设计费；大奖是浪费；假的；附件；按理说放假啦圣诞节弗兰克撒娇的分类进ADSL咖啡机阿斯利康附件阿杜里斯看风景的思考了附近拉萨的开发健康拉束带结发卡拉积分考虑到撒酒疯；拉束带结发卢卡斯大姐夫；拉束带结发；了卡圣诞节离开福建师大；雷锋精神；徕卡的房间里卡萨丁复健科拉萨的积分拉束带结发卢卡斯大姐夫看拉束带结发轮廓撒旦教发送的；理发士大夫士大夫是打发的数据了房间啊多斯拉克";
    tmpLabelStyle.compareLineNum = 3;
    tmpLabelStyle.assignLineNum = 2;
    tmpLabelStyle.labelShowType = FJFExpandLabelShowTypeExpandAndPickup;
    FJFExpandLabel *tmpLabel = [[FJFExpandLabel alloc] initWithFrame:CGRectMake(60, 150, 200, 200)];
    [tmpLabel updateLabelWithExpandLabelStyle:tmpLabelStyle];
    tmpLabel.numberOfLines = 0;
    tmpLabel.userInteractionEnabled = YES;
    tmpLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:tmpLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
}



@end
